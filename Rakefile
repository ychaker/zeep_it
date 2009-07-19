require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

desc 'Default: run unit tests.'
task :default => :test

desc 'Test the zeep_it plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the zeep_it plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'ZeepIt'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

PKG_FILES = FileList[ 
  '[a-zA-Z]*', 
  'generators/**/*', 
  'lib/**/*', 
  'rails/**/*', 
  'tasks/**/*', 
  'test/**/*'
]

spec = Gem::Specification.new do |s|
  s.name = "zeep_it"
  s.version = "0.0.1"
  s.author = "Youssef Chaker"
  s.email = "youssefchaker@youhhoo.com"
  s.homepage = "http://yafflers.example.com/"
  s.platform = Gem::Platform::RUBY
  s.summary = "Get your app Zeep Mobile ready"
  s.files = PKG_FILES.to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
end

desc 'Turn this plugin into a gem.'
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end 