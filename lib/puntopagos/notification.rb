module PuntoPagos
  class Notification
    def initialize env = nil
      @env = env
      @@config ||= PuntoPagos::Config.new(@env)
      @@function = "transaccion/notificar"
    end

    def correct? token, trx_id, amount, timestamp, pp_signature
      message = create_message token, trx_id, amount, timestamp
      authorization = Authorization.new(@env)
      signature = authorization.sign(message)
      signature == pp_signature
    end

    private

    def create_message token, trx_id, amount, timestamp
      @@function + "\n" + token + "\n" + trx_id + "\n" + amount + "\n" + timestamp
    end
  end
end