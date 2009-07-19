require 'openssl'
require 'base64'
require 'time'
require 'cgi'
require 'zeep/responses'

module Zeep
  module Auth
    MESSAGE_WINDOW = 10 # seconds
    @digest = OpenSSL::Digest::Digest.new('sha1')
    
    def self.split(auth)
      zeep, auth = auth.split(' ')
      api_key, *signature = auth.split(':')
      [zeep, api_key, signature.join(':')]
    end
    
    def self.validate_signature!(authorization, body, secret, http_date, expected_http_date = Time.now.httpdate)
      # Given a response, api validate that it's signed properly 
      expected_http_date = Time.parse(expected_http_date)
      request_date = Time.parse(http_date)
      if (expected_http_date - request_date).abs > MESSAGE_WINDOW
        # TODO: implement this as Zeep::Response
        raise RuntimeError.new("Message time differs to much from ZeepMobile's clock")
      end
  
      authorization = authorization.split(' ')      
      raise Zeep::InvalidAuthorization unless authorization[0] == 'Zeep'
      
      api_key, signature = authorization[1].split(':')
      raise Zeep::InvalidAuthorization if api_key.nil? || signature.nil?
  
      raise Zeep::SignatureDoesNotMatch unless signature == calculate_signature(body, api_key, secret, http_date)
      
      return true
    end

    def self.sign_request!(request, api_key, secret, http_date = Time.now.httpdate)
      signature = calculate_signature(request.body, api_key, secret, http_date)
      request['Authorization'] = "Zeep #{api_key}:#{signature}"
      request['Date'] = http_date
      return request
    end

    def self.calculate_signature(body, api_key, secret, http_date = Time.now.httpdate)
      # Given the body, date, api_key and secret return the base64 HMAC
      canonical_string = "#{api_key}#{http_date}#{body}"
      return Base64.encode64(OpenSSL::HMAC.digest(@digest, secret, canonical_string)).strip
    end
  end
end
