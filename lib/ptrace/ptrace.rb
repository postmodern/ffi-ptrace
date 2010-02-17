require 'ptrace/ffi'

module FFI
  module PTrace
    def PTrace.allow!
      PTrace.ptrace(:ptrace_traceme, 0, nil, nil)
    end
  end
end
