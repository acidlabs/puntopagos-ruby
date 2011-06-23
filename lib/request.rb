require 'json'
require 'net/http'
require 'net/https'

module PuntoPagos
  
  class NoDataError < Exception
  end
  
  class Request
      def initialize(env = nil)
        @env = env
        @@config ||= PuntoPagos::Config.new(@env)
        @@puntopagos_base_url ||= @@config.puntopagos_base_url
      end

      
      

      def validate
        #TODO the receiverList field not validating properly

        # @@schema_filepath = "../lib/pay_request_schema.json"
        # @@schema = File.open(@@schema_filepath, "rb"){|f| JSON.parse(f.read)}
        # see page 42 of PP Adaptive Payments PDF for explanation of all fields.
        #JSON::Schema.validate(@data, @@schema)
      end

      def create(data)
        raise NoDataError unless data
        get_headers("/transaccion/crear",data)
        response_data = call_api(data, "/transaccion/crear", :post)
        PuntoPagos::Response.new(response_data, @env)
      end

private:

      def get_headers(function, data)
        raise NoDataError unless data
        
        timestamp = Time.now.utc.to_s(:rfc822).sub(/\+0000/, 'GMT')
        message   = function+"\n"+data['trx_id'].to_s+"\n"+data['monto']+"\n"+timestamp
        signature = "PP "+PUNTOPAGOS_KEY+":"+sign(message)
        @@headers = {
          'User-Agent' => "puntopagos-ruby-#{PuntoPagos::VERSION}", 
          'Accept' => 'application/json',
          'Accept-Charset' => 'utf-8',
          'Content-Type' => 'application/json; charset=utf-8',
          'Fecha' => timestamp,
          'Autorizacion' => signature
           }
      
      end

      def call_api(data, path, method)
        #hack fix: JSON.unparse doesn't work in Rails 2.3.5; only {}.to_json does..
        api_request_data = JSON.unparse(data) rescue data.to_json
        url = URI.parse @@api_base_url
        http = Net::HTTP.new(url.host, 443)
        http.use_ssl = true

        resp, response_data = http.method(method).(path, api_request_data, @@headers)

        JSON.parse(response_data)
      end
      
      def sign(string)
          Base64.encode64(HMAC::SHA1.digest(@@config.puntopagos_secret, string)).chomp.gsub(/\n/,'')
      end
    end
end