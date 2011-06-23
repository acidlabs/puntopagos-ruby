module PuntoPagos
  class Repsonse
    def initialize(response, env = nil)
      @@config ||= PuntoPagos::Config.new(env)
      @@puntopagos_base_url ||= @@config.puntopagos_base_url
      @@response = response
      @@body = JSON.parse(response.body)
      
    end
    
    # TODO validate JSON
    def success?
      if @@response.code.to_i == 200
        @@body["respuesta"] == "00"
      end
    end
    
    def get_token
      @@body["token"]
    end
    
    def payment_process_url
      @@puntopagos_base_url + "/transaccion/procesar/"+get_token
    end
    
  end
end