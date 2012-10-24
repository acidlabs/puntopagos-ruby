require 'spec_helper'

describe PuntoPagos::Executioner do
  let! :executioner do
    PuntoPagos::Executioner.new
  end

  # Placeholder
  specify { executioner.should be_an_instance_of PuntoPagos::Executioner }
end
