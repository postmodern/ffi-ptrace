require 'ptrace/ffi'

module FFI
  module PTrace
    #
    # Makes the current process traceable by `ptrace`.
    #
    def PTrace.allow!
      PTrace.ptrace(:ptrace_traceme, 0, nil, nil)
    end
  end
end
