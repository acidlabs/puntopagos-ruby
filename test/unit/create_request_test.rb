require 'test_helper'


class CreateRequestTest < Test::Unit::TestCase

  def setup
    @req = PuntoPagos::Request.new('production')
  end

  def test_valid_create
    puts "-------"
    puts "webpay valid"

    data = {
  		"trx_id" 	=> "#{Time.now.to_i}",
  		"monto"		=> "100.00",
  		"medio_pago" => "3"
  		}
  	resp = @req.create("#{Time.now.to_i}", "100.00")
    puts "RESP: #{resp.success?}"
    assert resp.success? == true, "Pass"

#    payload = YAML.load_file(File.join(File.dirname(__FILE__),"..", "data","webpay_paylaod.yml"))
  end

  def test_invalid_webpay_pay
    puts "webpay invalid"

    data = {
  		'trx_id' 	=> "#{Time.now.to_i}"
  		}
  	resp = @req.create("#{Time.now.to_i}","10")

    assert resp.success? == false

  end

end