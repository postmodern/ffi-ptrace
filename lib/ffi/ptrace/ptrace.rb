require 'ffi/ptrace/types'
require 'ffi/ptrace/process'

require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    ffi_lib [FFI::CURRENT_PROCESS, 'c']

    attach_function :ptrace, [:ptrace_request, :pid_t, :pointer, :pointer], :long

    attach_variable :errno, :int

    #
    # Makes the current process traceable by `ptrace`.
    #
    def self.allow!
      ptrace(:ptrace_traceme, 0, nil, nil)
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
    def self.exec(program,*arguments)
      ret = Kernel.fork do
        allow!

        Kernel.exec(program,*arguments)
      end

      return Process.new(ret) if ret
    end
  end
end
