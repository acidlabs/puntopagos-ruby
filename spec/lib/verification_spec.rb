require 'spec_helper'

describe PuntoPagos::Verification do
  let! :verification do
    PuntoPagos::Verification.new
  end

  # Placeholder
  specify { verification.should be_an_instance_of PuntoPagos::Verification }

  # let! :config do
  #   config = double PuntoPagos::Config
  #   config.stub(:new)                 { |env = nil, config_override = nil| PuntoPagos::Config.allocate }
  #   config.stub(:puntopagos_base_url) { "pene" }
  #   config.stub(:puntopagos_key)      { "poto" }
  #   config.stub(:puntopagos_secret)   { "caca" }
  #   config.new
  # end

  # let! :amount do
  #   "100.00"
  # end

  # let! :trx_id do
  #   "9787415132"
  # end

  # let! :token do
  #   request  = PuntoPagos::Request.new nil, config
  #   response = request.create trx_id, "100.00"
  #   response.get_token
  # end

  # let! :verificator do
  #   PuntoPagos::Verification.new
  # end

  # context "given the transaction is accepted" do
  #   before :each do
  #     $response = "00"
  #   end

  #   it "should be valid" do
  #     verificator.verify(token, trx_id, amount).should be_true
  #   end
  # end

  # context "given the transaction is rejected" do
  #   before :each do
  #     $response = "99"
  #   end

  #   it "should not be valid" do
  #     verificator.verify(token, trx_id, amount).should be_false
  #   end
  # end
end
