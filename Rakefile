require 'rubygems'

begin
  require 'bundler/setup'
rescue LoadError => error
  abort error.message
end

require 'rubygems/tasks'

Gem::Tasks.new

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :test => :spec
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new  
