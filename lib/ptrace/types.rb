require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    typedef :int, :pid_t
  end
end
