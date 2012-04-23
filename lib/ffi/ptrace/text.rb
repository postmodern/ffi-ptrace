require 'ffi/ptrace/memory'

module FFI
  module PTrace
    class Text < Memory

      def get_word(address)
        @process.peek_text(address)
      end

      def put_word(address,value)
        @process.poke_text(address)
      end

    end
  end
end
