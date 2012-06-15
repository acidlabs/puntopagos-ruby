require 'base64'
require 'openssl'
require 'json'
require 'rest_client'


module PuntoPagos

  class NoDataError < Exception
  end

  class Request
    def initialize env = nil
      @env = env
      @@config ||= PuntoPagos::Config.new(@env)
      @@puntopagos_base_url ||= @@config.puntopagos_base_url
      @@function = "transaccion/crear"
    end

    def validate
      #TODO validate JSON must have monto and trx_id
    end

    def create trx_id, amount, payment_type = nil
      raise NoDataError unless trx_id and amount
      data = create_data trx_id, amount, payment_type

      timestamp = get_timestamp

      message = create_message(data['trx_id'], data['monto'], timestamp)
      authorization = PuntoPagos::Authorization.new(@env)
      signature = authorization.sign(message)
      executioner = PuntoPagos::Executioner.new(@env)

      response_data = executioner.call_api(data, @@function, :post, signature, timestamp)
      PuntoPagos::Response.new(response_data, @env)
    end


private

    def create_message trx_id, amount, timestamp
      @@function + "\n" + trx_id + "\n" + amount + "\n" + timestamp
    end

    def create_data trx_id, amount, payment_type = nil
      data = {}
      data['trx_id']      = trx_id
      data['monto']       = amount
      data['medio_pago']  = payment_type if payment_type
      data
    end

    def get_timestamp
      Time.now.strftime("%a, %d %b %Y %H:%M:%S GMT")
    end

  end
end