require 'ffi/ptrace/memory'

module FFI
  module PTrace
    class User < Memory

      def get_word(address)
        @process.peek_user(address)
      end

      def put_word(address,value)
        @process.poke_user(address)
      end

    end
  end
end
