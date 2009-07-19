require File.dirname(__FILE__) + '/test_helper.rb' 
require 'action_view/test_case'

include ZeepSmsHelper 

class ZeepSmsHelperTest < ActionView::TestCase 
  
  # TODO: find out how to get the render helper method to work in test
  # def test_zeep_form
  #   puts zeep_form('user_id')
  # end 
end 