# ZeepIt
require "zeep_it/routing"
require "zeep_it/commands"

%w{ models controllers views/zeep_sms helpers }.each do |dir| 
  path = File.join(File.dirname(__FILE__), 'app', dir)  
  $LOAD_PATH << path 
  ActiveSupport::Dependencies.load_paths << path 
  ActiveSupport::Dependencies.load_once_paths.delete(path) 
end

view_path = File.join(File.dirname(__FILE__), 'app', 'views')
if File.exist?(view_path)
  ActionController::Base.prepend_view_path(view_path) # push it just underneath the app
end
