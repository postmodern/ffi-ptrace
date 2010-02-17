require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    WORD_SIZE = (FFI::Platform::ADDRESS_SIZE / 8)

    if WORD_SIZE == 8
      REGS = enum [
        :r15,
        :r14,
        :r13,
        :r12,
        :rbp,
        :rbx,
        :r11,
        :r10,
        :r9,
        :r8,
        :rax,
        :rcx,
        :rdx,
        :rsi,
        :rdi,
        :orig_rax,
        :rip,
        :cs,
        :eflags,
        :rsp,
        :ss,
        :fs_base,
        :gs_base,
        :ds,
        :es,
        :fs,
        :gs
      ]
    else
      REGS = enum [
        :ebx,
        :ecx,
        :edx,
        :esi,
        :edi,
        :ebp,
        :eax,
        :ds,
        :es,
        :fs,
        :gs,
        :orig_eax,
        :eip,
        :cs,
        :efl,
        :uesp,
        :ss
      ]
    end

    # Operation not permitted
    EPERM = 1

    # No such process
    ESRCH = 3

    # I/O error
    EIO = 5

    typedef :int, :pid_t

  end
end
