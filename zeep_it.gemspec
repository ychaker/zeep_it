# Gem::Specification for ZeepIt
Gem::Specification.new do |s|
  s.name = "zeep_it"
  s.version = "0.0.4"
  s.author = "Youssef Chaker"
  s.email = "youssefchaker@youhhoo.com"
  s.homepage = "http://github.com/ychaker/zeep_it"
  s.platform = Gem::Platform::RUBY
  s.summary = "Get your app Zeep Mobile ready"
  s.description = "Get your app Zeep Mobile ready"
  s.files = [ 
    "README.rdoc",
    "MIT-LICENSE",
    "Rakefile",
    "install.rb", 
    "uninstall.rb", 
    "generators/zeep_it_route/zeep_it_route_generator.rb", 
    "lib/app/controllers/zeep_sms_controller.rb",
    "lib/app/helpers/zeep_sms_helper.rb",
    "lib/app/models/zeep_sms.rb",
    "lib/app/views/zeep_sms/index.erb",
    "lib/app/views/zeep_sms/incoming.erb",
    "lib/app/views/zeep_sms/_form.erb",
    "lib/db/migrate/20090719024916_create_zeep_sms.rb",
    "lib/zeep/auth.rb",
    "lib/zeep/messaging.rb",
    "lib/zeep/responses.rb",
    "lib/zeep/LICENSE",
    "lib/zeep/README",
    "lib/zeep_it/commands.rb",
    "lib/zeep_it/routing.rb",
    "lib/zeep_it.rb",
    "rails/init.rb", 
    "tasks/zeep_it_tasks.rake", 
    "test/database.yml",
    "test/debug.log",
    "test/route_generator_test.rb",
    "test/routing_test.rb",
    "test/schema.rb",
    "test/zeep_it_test.rb",
    "test/test_helper.rb",
    "test/zeep_sms_controller_test.rb",
    "test/zeep_sms_helper_test.rb",
    "test/zeep_sms_test.rb",
    "pkg/zeep_it-0.0.4.gem"
  ]
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end