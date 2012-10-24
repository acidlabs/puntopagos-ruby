require 'yaml'

module PuntoPagos
  # Public: Manage configurations variables
  # like production and sandbox URLs and puntopagos.yml config file
  class Config
    PUNTOPAGOS_BASE_URL = {
      production: "https://www.puntopagos.com/",
      sandbox:    "https://sandbox.puntopagos.com/"
    }

    # Public: Loads the configuration file puntopagos.yml
    # If it's a rails application it will take the file from the config/ directory
    #
    # env - Environment.
    #
    # Returns a Config object.
    def initialize env = nil
      @@env ||= env || Rails.env rescue "test"
    end

    def env
      @@env
    end

    def config_filepath
      @@config_filepath ||= File.join(Rails.root, "config", "puntopagos.yml") rescue File.join(File.dirname(__FILE__), "..", "..", "config", "puntopagos.yml")
    end

    def config env = env, config_filepath = config_filepath
      @@config ||= YAML.load_file(config_filepath)[env]
    end

    def puntopagos_base_url config = config
      @@puntopagos_base_url ||= PUNTOPAGOS_BASE_URL[config['environment'].to_sym]
    end

    def puntopagos_key config = config
      @@puntopagos_key ||= config['puntopagos_key']
    end

    def puntopagos_secret config = config
      @puntopagos_secret ||= config['puntopagos_secret']
    end
  end
end
