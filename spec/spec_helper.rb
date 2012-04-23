gem 'rspec', '~> 2.4'
require 'rspec'
require 'ffi/ptrace/version'

include FFI
include FFI::PTrace

CC             = (ENV['CC'] || 'cc')
PROGRAM        = File.join('spec','program')
PROGRAM_SOURCE = File.join('spec','program.c')

RSpec.configure do |spec|
  spec.before(:suite) do
    system CC, '-m32', PROGRAM_SOURCE, '-o', PROGRAM
  end
end
