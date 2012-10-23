module PuntoPagos
  class Response
    def initialize(response, env = nil)
      @@config ||= PuntoPagos::Config.new(env)
      @@puntopagos_base_url ||= @@config.puntopagos_base_url
      @@response = response

    end

    # TODO validate JSON
    def success?
      puts "#{@@response['respuesta']}"
      @@response["respuesta"] == "00"
    end

    def get_token
      @@response["token"]
    end

    def get_error
      @@response["error"]
    end

    def payment_process_url
      @@puntopagos_base_url + "transaccion/procesar/"+get_token
    end

  end
end