# desc "Explaining what the task does"
# task :zeep_it do
#   # Task goes here
# end
namespace :zeep_it do
  desc "Create ZeepIt YML file in the config directory"
  task :create_yml do
  
    ENV['RAILS_ROOT'] ||= File.dirname(__FILE__) + '/../../../..'

    unless File.exist?("#{ENV['RAILS_ROOT']}/config/zeep_it.yml")
      puts "Creating /config/zeep_it.yml"
      file = File.new("#{ENV['RAILS_ROOT']}/config/zeep_it.yml", "w") 

      file.puts( 
        "API_KEY: your_api_key \nSECRET_KEY: your_secret_key" 
      )
    end
  end
  
  namespace :db do
    description = "Migrate the database through scripts in vendor/plugins/zeep_it/lib/db/migrate"
    description << "and update db/schema.rb by invoking db:schema:dump."
    description << "Target specific version with VERSION=x. Turn off output with VERBOSE=false."
    desc description 
    task :migrate => :environment do
      ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
      ActiveRecord::Migrator.migrate("vendor/plugins/zeep_it/lib/db/migrate/", ENV["VERSION"] ? ENV["VERSION"].to_i : nil) 
      Rake::Task["db:schema:dump"].invoke if ActiveRecord::Base.schema_format == :ruby
    end
  end
  
  namespace :routes do
    desc "Generate routes for ZeepIt"
    task :generate do
      ruby "./script/generate zeep_it_route"
    end
    
    desc "Destroy routes for ZeepIt"
    task :destroy do
      ruby "./script/destroy zeep_it_route"
    end
  end
  
  desc "Initial setup: migrate db and create config/zeep_it.yml"
  task :setup do
    Rake::Task["zeep_it:db:migrate"].invoke 
    Rake::Task["zeep_it:create_yml"].invoke
    Rake::Task["zeep_it:routes:generate"].invoke
  end
end