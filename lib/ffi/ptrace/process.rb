require 'ffi/ptrace/memory_space'
require 'ffi/ptrace/user_regs'
require 'ffi/ptrace/user_fpregs'
require 'ffi/ptrace/ptrace'

module FFI
  module PTrace
    class Process

      # The `text` memory space
      attr_reader :text

      # The `data` memory space
      attr_reader :data

      # The `user-land` arguments memory space.
      attr_reader :user

      #
      # Creates a new Process with the given `pid`.
      #
      # @param [Integer] pid
      #   The ID of the process.
      #
      def initialize(pid)
        @pid = pid

        @text = MemorySpace.new(self)
        @data = MemorySpace.new(self)
        @user = MemorySpace.new(self)
      end

      #
      # Forks a new traceable process.
      #
      # @param [String] program
      #   The program to run within the forked process.
      #
      # @param [Array] args
      #   The arguments to run the program with.
      #
      # @return [Process]
      #   The process object.
      #
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

      #
      # Causes the process to continue executing.
      #
      def continue!
        ptrace(:ptrace_cont)
      end

      #
      # Kills the process.
      #
      def kill!
        ptrace(:ptrace_kill)
      end

      #
      # Causes the process to pause after every instruction.
      #
      def single_step!
        ptrace(:ptrace_singlestep)
      end

      #
      # Reads the values within the registers.
      #
      # @return [UserRegs]
      #   The current registers of the process.
      #
      def regs
        regs = UserRegs.new

        ptrace(:ptrace_getregs,nil,regs)
        return regs
      end

      #
      # Writes values to the registers.
      #
      # @param [UserRegs] new_regs
      #   The new register values to write.
      #
      # @return [UserRegs]
      #   The written registers.
      #
      def regs=(new_regs)
        ptrace(:ptrace_setregs,nil,new_regs)
        return new_regs
      end

      #
      # Reads the values within the floating-point registers.
      #
      # @return [UserFPRegs]
      #   The current floating-point registers of the process.
      #
      def fp_regs
        fp_regs = UserFPRegs.new

        ptrace(:ptrace_getfpregs,nil,fp_regs)
        return fp_regs
      end

      #
      # Writes values to the floating-point registers.
      #
      # @param [UserFPRegs] new_fp_regs
      #   The new floating-point register values to write.
      #
      # @return [UserFPRegs]
      #   The written floating-point registers.
      #
      def fp_regs=(new_fp_regs)
        ptrace(:ptrace_getfpregs,nil,new_fp_regs)
        return fp_regs
      end

      #
      # Attach to the process.
      #
      def attach!
        ptrace(:ptrace_attach)
      end

      #
      # Detaches from the process.
      #
      def detach!
        ptrace(:ptrace_detach)
      end

      def fpx_regs
        raise(RuntimeError,"#{self.class}#fpx_regs not implemented",caller)
      end

      def fpx_regs=(new_regs)
        raise(RuntimeError,"#{self.class}#fpx_regs= not implemented",caller)
      end

      #
      # Causes the process to pause after every system call.
      #
      def syscall_step!
        ptrace(:ptrace_syscall)
      end

      #
      # Sets the ptrace options.
      #
      # @param [Integer] new_options
      #   The ptrace option flags.
      #
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

      #
      # Calls `ptrace` on the process.
      #
      # @param [Symbol] request
      #   The requested `ptrace` function.
      #
      # @param [Integer] addr
      #   The optional address.
      #
      # @param [FFI::MemoryPointer, Integer] data
      #   The optional data.
      #
      # @return [Integer]
      #   The return value from `ptrace`.
      #
      # @raise [Errno::EACCESS]
      #   The process is not allowed to be traced.
      #
      # @raise [RuntimeError]
      #   Either the process no longer exists or is already being traced.
      #
      # @raise [IOError]
      #   The `ptrace` request was invalid or the memory address was invalid.
      #
      def ptrace(request,addr=nil,data=nil)
        ret = PTrace.ptrace(request,@pid,addr,data)

        case PTrace.errno
        when PTrace::EPERM
          raise(Errno::EACCESS,"The requested process (#{@pid}) couldn't be traced. Permission denied",caller)
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
