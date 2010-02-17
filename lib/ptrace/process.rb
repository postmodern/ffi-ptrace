require 'ptrace/user_regs'
require 'ptrace/user_fpregs'
require 'ptrace/ptrace'
require 'ptrace/ffi'

module FFI
  module PTrace
    class Process
      def initialize(pid)
        @pid = pid
      end

      def Process.fork(program,*args)
        ret = fork do
          PTrace.allow!

          exec(program,*args)
        end

        return Process.new(ret) if ret
      end

      def peek_text(addr)
        ptrace(:ptrace_peektext,addr,nil)
      end

      def peek_data(addr)
        ptrace(:ptrace_peekdata,addr,nil)
      end

      def peek_user(offset)
        ptrace(:ptrace_peekuser,offset,nil)
      end

      def poke_text(addr,data)
        ptrace(:ptrace_poketext,addr,data)
      end

      def poke_data(addr,data)
        ptrace(:ptrace_pokedata,addr,data)
      end

      def poke_user(offset,data)
        ptrace(:ptrace_pokeuser,offset,data)
      end

      def continue!
        ptrace(:ptrace_cont)
      end

      def kill!
        ptrace(:ptrace_kill)
      end

      def single_step!
        ptrace(:ptrace_singlestep)
      end

      def regs
        regs = UserRegs.new

        ptrace(:ptrace_getregs,nil,regs)
        return regs
      end

      def regs=(new_regs)
        ptrace(:ptrace_setregs,nil,new_regs)
        return new_regs
      end

      def fp_regs
        fp_regs = UserFPRegs.new

        ptrace(:ptrace_getfpregs,nil,fp_regs)
        return fp_regs
      end

      def fp_regs=(new_fp_regs)
        ptrace(:ptrace_getfpregs,nil,new_fp_regs)
        return fp_regs
      end

      def attach!
        ptrace(:ptrace_attach)
      end

      def detach!(exit_code=0)
        ptrace(:ptrace_detach,exit_code)
      end

      def fpx_regs
        raise(RuntimeError,"#{self.class}#fpx_regs not implemented",caller)
      end

      def fpx_regs=(new_regs)
        raise(RuntimeError,"#{self.class}#fpx_regs= not implemented",caller)
      end

      def syscall_step!
        ptrace(:ptrace_syscall)
      end

      def options=(new_options)
        ptrace(:ptrace_setoptions,nil,new_options)
      end

      def event_mesg
        raise(RuntimeError,"#{self.class}#event_mesg not implemented",caller)
      end

      def signal_info
        raise(RuntimeError,"#{self.class}#signal_info not implemented",caller)
      end

      def signal_info=(new_info)
        raise(RuntimeError,"#{self.class}#signal_info= not implemented",caller)
      end

      protected

      def ptrace(request,addr=nil,data=nil)
        ret = PTrace.ptrace(request,@pid,addr,data)

        case PTrace.errno
        when PTrace::EPERM
          raise(RuntimeError,"The requested process (#{@pid}) couldn't be traced. Permission denied",caller)
        when PTrace::ESRCH
          raise(RuntimeError,"The requested process (#{@pid}) doesn't exist or is being traced",caller)
        when PTrace::EIO
          raise(IOError,"The ptrace request was invalid or read/write was made from/to invalid area of memory",caller)
        end

        return ret
      end
    end
  end
end
