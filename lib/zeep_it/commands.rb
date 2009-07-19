require 'rails_generator'
require 'rails_generator/commands'

module ZeepIt #:nodoc:
  module Generator #:nodoc:
    module Commands #:nodoc:
      module Create
        def zeep_it_route
          logger.route "map.resources :zeep_sms"
          look_for = 'ActionController::Routing::Routes.draw do |map|'  
          unless options[:pretend] 
            gsub_file('config/routes.rb', /(#{Regexp.escape(look_for)})/mi){|match| "#{match}\n map.resources :zeep_sms\n"}
          end
        end
      end
      
      module Destroy
        def zeep_it_route
          logger.route "map.resources :zeep_sms"
          gsub_file 'config/routes.rb', /\n.+?map\.resources \:zeep_sms\n/mi, ''
        end
      end
      
      module List
        def zeep_it_route
        end
      end
      
      module Update
        def zeep_it_route
        end
      end
    end
  end
end 
Rails::Generator::Commands::Create.send  :include, ZeepIt::Generator::Commands::Create 
Rails::Generator::Commands::Destroy.send  :include, ZeepIt::Generator::Commands::Destroy 
Rails::Generator::Commands::List.send  :include, ZeepIt::Generator::Commands::List 
Rails::Generator::Commands::Update.send  :include, ZeepIt::Generator::Commands::Update 