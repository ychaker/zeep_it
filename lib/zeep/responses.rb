require 'net/http'

class Exception
  def is_zeep_response?
    false
  end
end

class Net::HTTPResponse
  def to_zeep
    clazz = Zeep.responses[self.code] || Zeep::UnexpectedError
    clazz.new(response.body)
  end
end

module Zeep
  def self.responses
    if @responses.nil?
      @responses = {}
      self.constants.each do |const_name|
        if (r = self.const_get(const_name)).ancestors.include?(Zeep::Response) && r != Response
          @responses[r.status_code.to_s] = r 
        end
      end
    end
    @responses
  end
  
  class Response < Exception
    attr_accessor :message
    
    def initialize(message = self.class::DEFAULT_MESSAGE)
      self.message = message
    end
    
    def self.display_name
      self.name =~ /([^:]+)$/
      $1
    end
    
    def self.is_error?
      self::STATUS_CODE >= 300
    end
    
    def self.all_good?
      false
    end
    def all_good?
      self.class.all_good?
    end
    
    def self.status_code
      self::STATUS_CODE
    end
        
    def message
      if @message.nil?
        self.class::DEFAULT_MESSAGE
      else
        @message
      end
    end
    
    def status_code
      self.class::STATUS_CODE
    end
    
    def is_zeep_response?
      true
    end
    
  end
  
  class OK < Response
    STATUS_CODE = 200
    DEFAULT_MESSAGE = "All is good in the hood."
    
    def self.all_good?
      true
    end
  end
  
  class InvalidAPIKey < Response
    STATUS_CODE = 403
    DEFAULT_MESSAGE = "The API Key was either not supplied, or has not been registered as a Zeep Mobile Application."
  end
  
  class MessageTooLong < Response
    STATUS_CODE = 400
    DEFAULT_MESSAGE = "The message you attempted to send was too many characters for the given method. See the specific method documentation for limitations."
  end
  
  class InvalidSubscription < Response
    STATUS_CODE = 400
    DEFAULT_MESSAGE = "The subscrtiption specified is not active or is blocking access from your application."
  end
  
  class InvalidAuthorization < Response
    STATUS_CODE = 403
    DEFAULT_MESSAGE = "The Authorization header was either not supplied or was not the correct format. See the Authentication documentation for more details."
  end
  
  class SignatureDoesNotMatch < Response
    STATUS_CODE = 403
    DEFAULT_MESSAGE = "The supplied HMAC+SHA1 signature was not valid for the parameter content or Secret Key. See the Authentication documentation for more details."
  end  
  
  class InternalServerError < Response
    STATUS_CODE = 500
    DEFAULT_MESSAGE = "An error has occured within the Zeep API. These errors are always logged and we are alerted. We will do our best to fix the problem ASAP."
  end
  
  class InvalidEndpoint < Response
    STATUS_CODE = 404
    DEFAULT_MESSAGE = "The URL used for the method endpoint is invalid. Make sure you are specifying a valid release date."
  end
  
  class UnexpectedError < Response
    STATUS_CODE = 555
    DEFAULT_MESSAGE = "You got me, this should never happen. If you see a 555 error, please email the contained message to support@zeepmobile.com."
  end
end
