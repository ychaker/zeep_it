class ZeepItRouteGenerator < Rails::Generator::Base #:nodoc:
  def manifest #:nodoc:
    record do |m|
      m.zeep_it_route
    end
  end
end 