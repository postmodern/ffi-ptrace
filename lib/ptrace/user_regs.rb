require 'ptrace/user_regs_32'
require 'ptrace/user_regs_64'

require 'ffi'

module FFI
  module PTrace
    class UserRegs < FFI::Struct

      if FFI::Platform::ADDRESS_SIZE == 64
        include UserRegs64
      else
        include UserRegs32
      end

    end
  end
end
