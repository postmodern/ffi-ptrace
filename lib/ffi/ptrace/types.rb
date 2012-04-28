require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    WORD_SIZE = (FFI::Platform::ADDRESS_SIZE / 8)

    # Operation not permitted
    EPERM = 1

    # No such process
    ESRCH = 3

    # I/O error
    EIO = 5

    enum :ptrace_request, [
      :ptrace_traceme, 0,
      :ptrace_peektext, 1,
      :ptrace_peekdata, 2,
      :ptrace_peekuser, 3,
      :ptrace_poketext, 4,
      :ptrace_pokedata, 5,
      :ptrace_pokeuser, 6,
      :ptrace_cont, 7,
      :ptrace_kill, 8, 
      :ptrace_singlestep, 9,
      :ptrace_getregs, 12,
      :ptrace_setregs, 13,
      :ptrace_getfpregs, 14,
      :ptrace_setfpregs, 15,
      :ptrace_attach, 16,
      :ptrace_detach, 17,
      :ptrace_getfpxregs, 18,
      :ptrace_setfpxregs, 19,
      :ptrace_syscall, 24,
      :ptrace_setoptions, 0x4200,
      :ptrace_geteventmsg, 0x4201,
      :ptrace_getsiginfo, 0x4202,
      :ptrace_setsiginfo, 0x4203
    ]

    enum :ptrace_options, [
      :ptrace_option_trace_sysgood, 0x01,
      :ptrace_option_trace_fork, 0x02,
      :ptrace_option_trace_vfork, 0x04,
      :ptrace_option_trace_clone, 0x08,
      :ptrace_option_trace_exec, 0x10,
      :ptrace_option_trace_vfork_done, 0x20,
      :ptrace_option_trace_exit, 0x40,
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
  end
end
