require 'ptrace/user_fpregs_32'
require 'ptrace/user_fpregs_64'

require 'ffi'

module FFI
  module PTrace
    class UserFPRegs < FFI::Struct

      if FFI::Platform::ADDRESS_SIZE == 64
        include UserFPRegs64
      else
        include UserFPRegs32
      end

    end
  end
end
