module ZeepSmsHelper
  
  def zeep_form(user_id = '')
    render :partial => 'zeep_sms/form', :locals => {:user_id => user_id}
  end
end