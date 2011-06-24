require 'test_helper'


class CreateRequestTest < Test::Unit::TestCase
  
  def setup 
    @req = PuntoPagos::Request.new('test')
  end
  
  def test_valid_create
    puts "-------"
    puts "webpay valid"
    
    data = { 
  		"trx_id" 	=> 3342313,
  		"monto"		=> "100.00"
  		}    
  	resp = @req.create(data)
    
    assert resp.success? == true
    
#    payload = YAML.load_file(File.join(File.dirname(__FILE__),"..", "data","webpay_paylaod.yml"))
  end
  
  def test_invalid_webpay_pay
    puts "webpay invalid"
    
    data = { 
  		'trx_id' 	=> "#{Time.now.to_i}"
  		}    
  	resp = @req.create(data)
    
    assert resp.success? == false, "Pass"
    
  end

end