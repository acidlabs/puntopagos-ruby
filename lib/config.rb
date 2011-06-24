require 'yaml'

module PuntoPagos
  class Config
    PUNTOPAGOS_BASE_URL = {
      :production => "www.puntopagos.com/",
      :sandbox => "sandobox.puntopagos.com/"
    }
    
    attr_accessor :config_filepath, :puntopagos_base_url, :puntopagos_key, :puntopagos_secret
    
    def initialize(env = nil, config_override = nil)
      if env
        # For non-rails apps
        @config_filepath = File.join(File.dirname(__FILE__), "..", "config", "puntopagos.yml")
        load(env)
      else
        @config_filepath = File.join(Rails.root, "config", "puntopagos.yml")
        load(Rails.env)
      end
    end
    
    def load(rails_env)
      config = YAML.load_file(@config_filepath)[rails_env]
      pp_env = config['environment'].to_sym
      @puntopagos_base_url = PUNTOPAGOS_BASE_URL[pp_env]
      @puntopagos_key = config['puntopagos_key']
      @puntopagos_secret = config['puntopagos_secret']
    end
    
  end
end