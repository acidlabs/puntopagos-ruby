require 'test_helper'

class CreateRequestTest < Test::Unit::TestCase
  def test_check
    puts "testing check"
    status = PuntoPagos::Status.new("test")
    status.check "MGSQO0IO3GYA13B6", "1358470630", "10.00"
    assert status.valid? == true, "Fail"
  end
end