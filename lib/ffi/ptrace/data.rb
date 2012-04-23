require 'ffi/ptrace/memory'

module FFI
  module PTrace
    class Data < Memory

      def get_word(address)
        @process.peek_data(address)
      end

      def put_word(address,value)
        @process.poke_data(address)
      end

    end
  end
end
