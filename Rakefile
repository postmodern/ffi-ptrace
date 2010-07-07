require 'rubygems'
require 'bundler'

require 'rake'
require 'jeweler'
require './lib/ptrace/version.rb'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

Jeweler::Tasks.new do |gem|
  gem.name = 'ffi-ptrace'
  gem.version = FFI::PTrace::VERSION
  gem.summary = %Q{Ruby FFI bindings for Linux ptrace.}
  gem.description = %Q{Ruby FFI bindings for Linux ptrace.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/sophsec/ffi-ptrace'
  gem.authors = ['Postmodern']
  gem.has_rdoc = 'yard'
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs += ['lib', 'spec']
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.spec_opts = ['--options', '.specopts']
end

task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
