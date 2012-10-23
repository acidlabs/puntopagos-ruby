module PuntoPagos

  # Public: This class manage the signing of a message using
  # the secret and api-key defined in puntopagos.yml
  class Verification
    def initialize env = nil
      @env = env
      @@config ||= PuntoPagos::Config.new(env)
      @@function = "transaccion/traer"
      @@path = "transaccion"
    end

    # Public: Signs a string using the secret and api-key defined in puntopagos.yml
    #
    # string - The String to be signed
    # Returns the signed String.
    def verify token, trx_id, amount
      executioner = PuntoPagos::Executioner.new(@env)
      timestamp = get_timestamp
      message = create_message token, trx_id, amount, timestamp
      authorization = PuntoPagos::Authorization.new(@env)
      signature = authorization.sign(message)

      puts "SIGNATURE: #{signature} TIMESTAMP: #{timestamp} TOKEN: #{token} TRX: #{trx_id}"
      puts "MESSAGE: #{message}"

      response = executioner.call_api(nil, @@path, :get, signature, timestamp)

      valid?(response)
    end

    def valid? response
      response["respuesta"] == "00"
    end

    private

    def get_timestamp
      Time.now.strftime("%a, %d %b %Y %H:%M:%S GMT")
    end

    def create_message token, trx_id, amount, timestamp
      @@function  + "\n" + token + "\n" + trx_id + "\n" + amount + "\n" + timestamp
    end

  end
end