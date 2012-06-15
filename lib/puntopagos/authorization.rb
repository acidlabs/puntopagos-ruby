require 'base64'
require 'openssl'

module PuntoPagos
  class Authorization
    def initialize env = nil
      @@config ||= PuntoPagos::Config.new(env)
    end

    def sign(string)
      encoded_string = Base64.encode64(OpenSSL::HMAC.digest('sha1',@@config.puntopagos_secret, string)).chomp
      "PP "+@@config.puntopagos_key+":"+ encoded_string
    end
  end
end