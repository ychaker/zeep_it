#:nodoc:
class ZeepItGenerator < Rails::Generator::NamedBase
  #:nodoc:
  def manifest
    record do |m|
      # m.directory "lib"
      # m.template 'README', "README"
    end
  end
end
