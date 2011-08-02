require 'base64'
require 'openssl'
require 'json'
require 'rest_client'


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
        #TODO validate JSON must have monto and trx_id
      end

      def create(data)
        raise NoDataError unless data
        get_headers("transaccion/crear",data)
        response_data = call_api(data, "/transaccion/crear", :post)
        PuntoPagos::Response.new(response_data, @env)
      end
      
    

private

      def get_headers(function, data)
        raise NoDataError unless data
        
        timestamp = Time.now.strftime("%a, %d %b %Y %H:%M:%S GMT")
        message   = function+"\n"+data['trx_id'].to_s+"\n"+data['monto'].to_s+"\n"+timestamp
        signature = "PP "+@@config.puntopagos_key+":"+sign(message).chomp!
        @@headers = {
          'User-Agent' => "puntopagos-ruby-#{PuntoPagos::VERSION}", 
          'Accept' => 'application/json',
          'Accept-Charset' => 'utf-8',
          'Content-Type'  => 'application/json; charset=utf-8',
          'Fecha'         => timestamp,
          'Autorizacion'  => signature
           }
      end

      def call_api(data, path, method)
        #hack fix: JSON.unparse doesn't work in Rails 2.3.5; only {}.to_json does..
        api_request_data = JSON.unparse(data) rescue data.to_json
        resp = RestClient.method(method).call(@@puntopagos_base_url+path, data.to_json, @@headers)
        
        JSON.parse(resp)
      end
      
      def sign(string)
          Base64.encode64(OpenSSL::HMAC.digest('sha1',@@config.puntopagos_secret, string))
      end
    end
end