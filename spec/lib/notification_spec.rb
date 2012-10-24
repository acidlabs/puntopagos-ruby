require 'spec_helper'

describe PuntoPagos::Notification do
  let! :notification do
    PuntoPagos::Notification.new
  end

  # Placeholder
  specify { notification.should be_an_instance_of PuntoPagos::Notification }
end
