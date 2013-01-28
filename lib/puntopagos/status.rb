module PuntoPagos
  class Status
    def initialize env = nil
      @env = env
      @@config ||= PuntoPagos::Config.new(env)
      @@function = "transaccion/traer"
      @@endpoint = "transaccion"
      @@response = nil
    end


    def check  token, trx_id, amount
      timestamp = get_timestamp
      message = create_message(token, trx_id, amount, timestamp)
      authorization = PuntoPagos::Authorization.new(@env)
      signature = authorization.sign(message)
      executioner = PuntoPagos::Executioner.new(@env)
      @@response = executioner.call_api(token, @@endpoint, :get, signature, timestamp)
    end

    def valid?
      @@response['respuesta'] == '00'
    end

    def error
      @@response['error']
    end

    private

    def create_message token, trx_id, amount, timestamp
      @@function + "\n" + token + "\n" + trx_id + "\n" + amount + "\n" + timestamp
    end

    def get_timestamp
      Time.now.strftime("%a, %d %b %Y %H:%M:%S GMT")
    end
  end
end