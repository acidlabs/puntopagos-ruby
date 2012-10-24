require 'spec_helper'

describe PuntoPagos::Authorization do
  let! :authorization do
    PuntoPagos::Authorization.new
  end

  # Placeholder
  specify { authorization.should be_an_instance_of PuntoPagos::Authorization }
end
