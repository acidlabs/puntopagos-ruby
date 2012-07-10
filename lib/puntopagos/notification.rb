module PuntoPagos
  class Notification
    def initialize env = nil
      @env = env
      @@config ||= PuntoPagos::Config.new(@env)
      @@function = "transaccion/notificar"
    end

    def valid? headers, params
      timestamp = get_timestamp headers

      message = create_message params["token"], params["trx_id"], params["monto"].to_s, timestamp
      authorization = Authorization.new(@env)
      signature = authorization.sign(message)
      signature == pp_signature(headers)

    end

    private

    def create_message token, trx_id, amount, timestamp
      @@function + "\n" + token + "\n" + trx_id + "\n" + amount + "\n" + timestamp
    end

    def pp_signature headers
      headers['Autorizacion']
    end

    def get_timestamp headers
      headers['Fecha']
    end
  end
end