require "spec_helper"

describe PuntoPagos::Config do
  let! :config do
    PuntoPagos::Config.new
  end

  let! :config_file do
    {
      "#{config.env}" => {
        "environment"       => "sandbox",
        "puntopagos_key"    => "asdf",
        "puntopagos_secret" => "1234"
      }
    }
  end

  specify { config.env.should eq 'test' }
  specify { config.config_filepath.should match /\.\.\/\.\.\/config\/puntopagos\.yml/ }

  it "should load the config file" do
    YAML.stub(:load_file).and_return config_file
    config.config.should have_key "environment"
  end

  specify { config.puntopagos_base_url.should match /sandbox\.puntopagos\.com/ }
  specify { config.puntopagos_key.should eq "asdf" }
  specify { config.puntopagos_secret.should eq "1234" }
end
