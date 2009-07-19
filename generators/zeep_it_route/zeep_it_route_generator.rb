class ZeepItRouteGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.zeep_it_route
    end
  end
end 