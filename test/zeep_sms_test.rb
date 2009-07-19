require File.dirname(__FILE__) + '/test_helper.rb' 

class ZeepSMSTest < ActiveRecord::TestCase 
  load_schema 
  
  def test_zeep_sms
    assert_kind_of ZeepSms, ZeepSms.new 
  end
  
  def test_pluralize_name
    assert_equal "ZeepSms", "ZeepSms".pluralize
  end
  
  def test_fetching_keys
    assert_not_nil ZeepSms::API_KEY
    assert_not_nil ZeepSms::SECRET_KEY
  end

  # def test_send_sms_with_bad_authorization
  #   assert_kind_of Zeep::InvalidAuthorization, ZeepSms::send_sms("fake_login", "fake body")
  # end
  
  def test_parse_for_keyword
    sms = ZeepSms.new(:login => 'zeep_it', :raw => 'ZeepIt123 user:ychaker spotted at DT mall')
    user = sms.parse_sms(:keyword => 'user:')
    assert_equal 'ychaker', user[:key]
    
    sms = ZeepSms.new(:login => 'zeep_it', :raw => 'ZeepIt123 @ychaker spotted at DT mall')
    user = sms.parse_sms(:pattern => /@/)
    assert_equal 'ychaker', user[:key]
    
    sms = ZeepSms.new(:login => 'zeep_it', :raw => 'ZeepIt123 ay caramba! @ychaker spotted at DT mall')
    user = sms.parse_sms(:common => 'twitter')
    assert_equal 'ychaker', user[:key]
    assert_equal 'ay caramba! spotted at DT mall', user[:rest]
    
    sms = ZeepSms.new(:login => 'zeep_it', :raw => 'ZeepIt123 y!chaker spotted at DT mall')
    user = sms.parse_sms({:common => 'bang'}, true)
    assert_equal 'ychaker', user[:key]
  end
end 