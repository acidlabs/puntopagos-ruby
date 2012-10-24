require 'spec_helper'

describe PuntoPagos::Response do
  let! :response do
    PuntoPagos::Response.new PuntoPagos::Request.new
  end

  # Placeholder
  specify { response.should be_an_instance_of PuntoPagos::Response }
end
