require 'ffi/ptrace/types'
require 'ffi/ptrace/process'

require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    ffi_lib 'c'

    enum :ptrace_request, [
      :ptrace_traceme,
      :ptrace_peektext,
      :ptrace_peekdata,
      :ptrace_peekuser,
      :ptrace_poketext,
      :ptrace_pokedata,
      :ptrace_pokeuser,
      :ptrace_cont,
      :ptrace_kill,
      :ptrace_singlestep,
      :ptrace_getregs,
      :ptrace_setregs,
      :ptrace_getfpregs,
      :ptrace_setfpregs,
      :ptrace_attach,
      :ptrace_detach,
      :ptrace_getfpxregs,
      :ptrace_setfpxregs,
      :ptrace_syscall,
      :ptrace_setoptions,
      :ptrace_geteventmsg,
      :ptrace_getsiginfo,
      :ptrace_setsiginfo
    ]

    OPTIONS = enum [
      :ptrace_option_trace_sysgood, 1 << 0,
      :ptrace_option_trace_fork, 1 << 1,
      :ptrace_option_trace_vfork, 1 << 2,
      :ptrace_option_trace_clone, 1 << 3,
      :ptrace_option_trace_exec, 1 << 4,
      :ptrace_option_trace_vfork_done, 1 << 5,
      :ptrace_option_trace_exit, 1 << 6,
      :ptrace_option_mask, 0x7f
    ]

    EVENTS = enum [
      :ptrace_event_fork, 1,
      :ptrace_event_vfork, 2,
      :ptrace_event_clone, 3,
      :ptrace_event_exec, 4,
      :ptrace_event_vfork_done, 5,
      :ptrace_event_exit, 6
    ]

    attach_function :ptrace, [:ptrace_request, :pid_t, :pointer, :pointer], :long

    attach_variable :errno, :int

    #
    # Makes the current process traceable by `ptrace`.
    #
    def PTrace.allow!
      PTrace.ptrace(:ptrace_traceme, 0, nil, nil)
    end

    #
    # Executes a new traceable process.
    #
    # @param [String] program
    #   The program to run within the forked process.
    #
    # @param [Array<String>] arguments
    #   The arguments to run the program with.
    #
    # @return [Process]
    #   The process object.
    #
    def PTrace.exec(program,*arguments)
      ret = Kernel.fork do
        PTrace.allow!

        Kernel.exec(program,*arguments)
      end

      return Process.new(ret) if ret
    end
  end
end
