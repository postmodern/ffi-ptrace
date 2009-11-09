require 'ffi'

require 'ptrace/typedefs'

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

    enum :ptrace_setoptions, [
      :ptrace_option_trace_sysgood, 1 << 0,
      :ptrace_option_trace_fork, 1 << 1,
      :ptrace_option_trace_vfork, 1 << 2,
      :ptrace_option_trace_clone, 1 << 3,
      :ptrace_option_trace_exec, 1 << 4,
      :ptrace_option_trace_vfork_done, 1 << 5,
      :ptrace_option_trace_exit, 1 << 6,
      :ptrace_option_mask, 0x7f
    ]

    enum :ptrace_eventcodes, [
      :ptrace_event_fork, 1,
      :ptrace_event_vfork, 2,
      :ptrace_event_clone, 3,
      :ptrace_event_exec, 4,
      :ptrace_event_vfork_done, 5,
      :ptrace_event_exit, 6
    ]

    # Operation not permitted
    EPERM = 1

    # No such process
    ESRCH = 3

    # I/O error
    EIO = 5

    attach_function :ptrace, [:ptrace_request, :pid_t, :pointer, :pointer], :long

  end
end
