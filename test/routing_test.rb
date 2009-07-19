require "#{File.dirname(__FILE__)}/test_helper" 

class RoutingTest < Test::Unit::TestCase 
  
  def setup 
    ActionController::Routing::Routes.draw do |map| 
      map.zeep_sms 
    end  
  end  
  
  def test_zeep_sms_route 
    assert_recognition :get, "/zeep_sms", :controller => "zeep_sms", :action => "index"  
  end  
  
private 
  def assert_recognition(method, path, options)  
    result = ActionController::Routing::Routes.recognize_path(path, :method => method)  
    assert_equal options, result 
  end 
end 