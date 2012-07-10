require 'test_helper'


class CreateRequestTest < Test::Unit::TestCase

  def setup
    @req = PuntoPagos::Request.new('production')
  end

  def test_valid_create
    puts "-------"
    puts "webpay valid"

    resp = @req.create("#{Time.now.to_i}", "100.00")

    assert resp.success? == true, "Pass"

#    payload = YAML.load_file(File.join(File.dirname(__FILE__),"..", "data","webpay_paylaod.yml"))
  end

  def test_invalid_webpay_pay
    puts "webpay invalid"

  	resp = @req.create("#{Time.now.to_i}","10")

    assert resp.success? == false

  end

  def test_notification
    puts "testing notification"
    notification                                = PuntoPagos::Notification.new('test')
    headers                                     = {'Fecha' => 'Thu, 14 Jun 2012 22:52:47 GMT', 'Autorizacion' => 'PP rkdXmAGWLHCKdPyyk6ig:qOSavthLY3ElqsRCtxFEl02lL1s='}
    params                                      = {'token' => 'M5N1DAE6PALVAF8K', 'monto' => "1000000.0", 'trx_id' => '9787415132'}
    assert notification.valid?(headers, params) == true
  end

end