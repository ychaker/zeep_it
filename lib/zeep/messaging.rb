#require 'zeep/auth'
require 'net/http'
require 'net/https'

require 'zeep/auth'
require 'zeep/responses'

module Zeep
  module Base
    @@base_url = 'https://api.zeepmobile.com/'
    @@api_key = ''
    @@secret_key = ''
    
    def self.configure_credentials(api_key, secret_key)
      @@api_key = api_key
      @@secret_key = secret_key
    end
    
    def self.base_url
      @@base_url
    end
    def self.base_url=(base_url)
      @@base_url = base_url
    end
    
    def self.api_key 
      @@api_key
    end
    def self.api_key=(key)
      @@api_key = key
    end
    
    def self.secret_key 
      @@secret_key
    end
    def self.secret_key=(key)
      @@secret_key = key
    end
  end
  
  module Messaging
    
    @@release_date = '2008-07-14'
    
    def self.release_date
      @@release_date
    end
    def self.release_date=(date)
      @@release_date = date
    end
    
    def self.base_endpoint
      "#{Base.base_url}/messaging/#{@@release_date}"
    end
        
    def self.send_message(user_id, body)
      uri = URI.parse("#{base_endpoint}/send_message")
      
      request = Net::HTTP::Post.new(uri.path)
      request['Accepts'] = 'text/plain'
      request.set_form_data({'user_id' => user_id, 'body' => body})
      
      Zeep::Auth.sign_request!(request, Base.api_key, Base.secret_key)
      
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = (uri.scheme == "https")
      http_response = http.start {|http| http.request(request)}
      
      # TODO: Extract message guid
      
      if zeep_response = http_response.to_zeep
        return zeep_response
      else
        # TODO: 
        raise "Error: #{http_response.body}"
      end
    end
  end
end
