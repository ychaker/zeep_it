require File.dirname(__FILE__) + '/test_helper.rb' 
require 'zeep_sms_controller' 
require 'action_controller/test_process' 

class ZeepSmsController; def rescue_action(e) raise e end; end 

class ZeepSmsControllerTest < ActionController::TestCase 

  def setup 
    @controller = ZeepSmsController.new 
    @request = ActionController::TestRequest.new 
    @response = ActionController::TestResponse.new 
    
    ActionController::Routing::Routes.draw do |map| 
      map.resources :woodpeckers  
    end  
  end  
  
  def test_index 
    get :index  
    assert_response :success  
  end
  
  def test_incoming 
    get :incoming  
    assert_response :success  
  end
end 