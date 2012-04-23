require 'ffi/ptrace/version'

require 'spec_helper'

describe PTrace do
  it "should have a VERSION constant" do
    described_class.const_defined?('VERSION').should == true
  end
end
