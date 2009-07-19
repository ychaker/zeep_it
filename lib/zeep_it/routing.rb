module ZeepIt #:nodoc:  
  module Routing #:nodoc:  
    module MapperExtensions 
      def zeep_sms 
        @set.add_route("/zeep_sms", {:controller => "zeep_sms", :action => "index"})  
      end  
    end  
  end 
end 

ActionController::Routing::RouteSet::Mapper.send :include, ZeepIt::Routing::MapperExtensions 