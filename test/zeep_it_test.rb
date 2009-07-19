require File.dirname(__FILE__) + '/test_helper.rb' 

class ZeeptItTest < Test::Unit::TestCase 
  load_schema 
  
  class Zeep < ActiveRecord::Base 
  end  
   
  
  def test_schema_has_loaded_correctly 
    assert_equal [], Zeep.all
  end 
end