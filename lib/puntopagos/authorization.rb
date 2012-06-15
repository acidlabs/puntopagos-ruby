require 'base64'
require 'openssl'

module PuntoPagos
  class Authorization
    def initialize env = nil
      @@config ||= PuntoPagos::Config.new(env)
    end

    def sign(string)
      "PP "+@@config.puntopagos_key+":"+ Base64.encode64(OpenSSL::HMAC.digest('sha1',@@config.puntopagos_secret, string)).chomp
    end
  end
end