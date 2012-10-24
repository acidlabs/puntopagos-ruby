require 'spec_helper'

describe PuntoPagos::Request do
  let! :request do
    PuntoPagos::Request.new
  end

  # Placeholder
  specify { request.should be_an_instance_of PuntoPagos::Request }
end
