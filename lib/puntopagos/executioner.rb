require 'json'
require 'rest_client'

module PuntoPagos
  class Executioner
    def initialize env = nil
      @@config ||= PuntoPagos::Config.new(env)
      @@puntopagos_base_url ||= @@config.puntopagos_base_url
    end

    def call_api data, path, method, signature, timestamp
      #hack fix: JSON.unparse doesn't work in Rails 2.3.5; only {}.to_json does..
      headers          = set_headers(signature, timestamp)
      #api_request_data = JSON.unparse(data) rescue data.to_json
      if method == :post
        resp             = RestClient.method(method).call(@@puntopagos_base_url+path, data.to_json, headers)
      elsif method == :get
        resp             = RestClient.method(method).call(@@puntopagos_base_url+path+"/"+data, headers)
      end
      JSON.parse(resp)
    end

    private

    def set_headers signature, timestamp
      headers = {
        'User-Agent'     => "puntopagos-ruby-#{PuntoPagos::VERSION}",
        'Accept'         => 'application/json',
        'Accept-Charset' => 'utf-8',
        'Content-Type'   => 'application/json; charset=utf-8',
        'Fecha'          => timestamp,
        'Autorizacion'   => signature
      }
    end
  end
end