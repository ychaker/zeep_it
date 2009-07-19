require 'rubygems'
require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

# Gem::Specification for ZeepIt
PKG_FILES = FileList[ 
  '[a-zA-Z]*', 
  'generators/**/*', 
  'lib/**/*', 
  'rails/**/*', 
  'tasks/**/*', 
  'test/**/*'
]

Gem::Specification.new do |s|
  s.name = "zeep_it"
  s.version = "0.0.3"
  s.author = "Youssef Chaker"
  s.email = "youssefchaker@youhhoo.com"
  s.homepage = "http://github.com/ychaker/zeep_it"
  s.platform = Gem::Platform::RUBY
  s.summary = "Get your app Zeep Mobile ready"
  s.description = "Get your app Zeep Mobile ready"
  s.files = PKG_FILES.to_a
  s.require_path = "lib"
  s.has_rdoc = true
  s.extra_rdoc_files = ["README.rdoc"]
end