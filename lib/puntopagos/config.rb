require 'yaml'

module PuntoPagos
  # Public: Manage configurations variables
  # like production and sandbox URLs and puntopagos.yml config file
  class Config
    PUNTOPAGOS_BASE_URL = {
      :production => "https://www.puntopagos.com/",
      :sandbox => "https://sandbox.puntopagos.com/"
    }
    
    attr_accessor :config_filepath, :puntopagos_base_url, :puntopagos_key, :puntopagos_secret
    
    # Public: Loads the configuration file puntopagos.yml
    # If it's a rails application it will take the file from the config/ directory
    #
    # env - Environment.
    #
    # Returns a Config object.
    def initialize env = nil, config_override = nil
      if env
        # For non-rails apps
        @config_filepath = File.join(File.dirname(__FILE__), "..", "..", "config", "puntopagos.yml")
        load(env)
      else
        @config_filepath = File.join(Rails.root, "config", "puntopagos.yml")
        load(Rails.env)
      end
    end
    
    private 

    # Public: Initialize variables based on puntopagos.yml
    #
    # rails_env - Environment.
    #
    # Returns nothing.
    def load(rails_env)
      config = YAML.load(ERB.new(File.read(@config_filepath)).result)[rails_env]
      pp_env = config['environment'].to_sym
      @puntopagos_base_url = PUNTOPAGOS_BASE_URL[pp_env]
      @puntopagos_key = config['puntopagos_key']
      @puntopagos_secret = config['puntopagos_secret']
    end
    
  end
end