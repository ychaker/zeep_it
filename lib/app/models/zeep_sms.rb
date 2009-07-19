require 'rubygems'
require 'zeep/messaging'

class ZeepSms < ActiveRecord::Base
  RAILS_ROOT ||= File.dirname(__FILE__) + '/../../../..'
  file = YAML::load(IO.read("#{RAILS_ROOT}/config/zeep_it.yml"))
  
  # Zeep Mobile keys extracted from config/zeep_it.yml
  SECRET_KEY = file['SECRET_KEY']
  API_KEY = file['API_KEY']
  
  # Send any SMS by providing the user loging and body
  #
  # Example:
  #   ZeepSms::send_sms('user_id', 'body of SMS')
  def self.send_sms(login, body)
    Zeep::Base.configure_credentials(self::API_KEY, self::SECRET_KEY)
    Zeep::Messaging.send_message(login, body)
  end
  
  # Send the SMS 
  #
  # Example:
  #   sms = ZeepSms.new(:login=> 'user_id', :raw =>'body of SMS')
  #   sms.send_text
  def send_text
    Zeep::Base.configure_credentials(self::API_KEY, self::SECRET_KEY)
    Zeep::Messaging.send_message(self.login, self.raw)
  end
  
  # Parse an SMS for a particular keyword or pattern
  #
  # Examples:
  #   parse_for(:keyword => 'user:') 
  #     => returns the text found after the keywork and before the next space
  #   parse_for(:pattern => /[0-9]/) 
  #     => returns the text found after the first digit and before the next space
  #   parse_for(:common => 'twitter')
  #     => returns the text found after the first '@' and before the next space
  #   parse_for({:common => 'bang'}, true)
  #     => returns the text found between the previous space and the next space
  #     => removing the '!' in between
  #
  # Also returns the rest of the SMS omitting the 5-8 code in the beginning
  def parse_sms(hash={}, keepPrevious=false)
    prev = /.*/
    if keepPrevious
      prev = ''
    end
    key, rest = ''
    result = {:key => key, :rest => rest}
    keyword = extract_keyword(hash)
    key = parse_for(self.raw, keyword, keepPrevious)
    rest = self.raw.sub(/#{keyword}#{key}\s+/, '')
    rest.sub!(/[\w]+\s+{1}/, '').chomp!
    result = {:key => key, :rest => rest}
  end
  
private
  def extract_keyword(hash={}) #:nodoc:
    keyword = ''
    if !hash[:keyword].blank?
      keyword = hash[:keyword]
    elsif !hash[:pattern].blank?
        keyword = hash[:pattern]
    elsif !hash[:common].blank?
      if hash[:common] == 'twitter'
        keyword = '@'
      elsif hash[:common] == 'hashtag'
        keyword = '#'
      elsif hash[:common] == 'USD'
        keyword = '$'
      elsif hash[:common] == 'percent'
        keyword = '%'
      elsif hash[:common] == 'bang'
        keyword = '!'
      elsif hash[:common] == 'colon'
        keyword = ':'
      end
    end
    keyword
  end
  
  def parse_for(body, keyword, keepPrevious=false) #:nodoc:
    prev = /.*/
    if keepPrevious
      prev = ''
    end
    result = ''
    unless keyword.blank?
      body.split(/\s+/).each do |word|
        regex = /#{keyword}/
        if regex.match(word)
          result = word.sub(/#{prev}#{keyword}/, '')
          break
        end
      end
    end
    result
  end
end