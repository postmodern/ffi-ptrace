require 'ffi/ptrace/user_regs_32'
require 'ffi/ptrace/user_regs_64'
require 'ffi/ptrace/types'

require 'ffi'

module FFI
  module PTrace
    class UserRegs < FFI::Struct

      if WORD_SIZE == 64
        include UserRegs64
      else
        include UserRegs32
      end

    end
  end
end
