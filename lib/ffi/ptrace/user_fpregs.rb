require 'ffi/ptrace/user_fpregs_32'
require 'ffi/ptrace/user_fpregs_64'
require 'ffi/ptrace/types'

require 'ffi'

module FFI
  module PTrace
    class UserFPRegs < FFI::Struct

      if WORD_SIZE == 64
        include UserFPRegs64
      else
        include UserFPRegs32
      end

    end
  end
end
