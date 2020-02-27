require 'ffi/ptrace/version'

require 'spec_helper'

describe PTrace do
  it "should have a VERSION constant" do
    expect(described_class.const_defined?('VERSION')).to be(true)
  end
end
