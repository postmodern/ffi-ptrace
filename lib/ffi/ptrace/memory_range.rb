require 'ffi/ptrace/types'

module FFI
  module PTrace
    class MemoryRange

      include Enumerable

      #
      # Creates an `Enumerable` memory range.
      #
      # @param [MemorySpace] memory
      #   The memory space that the range covers.
      #
      # @param [Integer] lower
      #   The lower bound address of the range.
      #
      # @param [Integer] upper
      #   The upper bound address of the range.
      #
      def initialize(memory,lower,upper)
        @memory = memory
        @lower = lower
        @upper = upper
      end

      #
      # Reads data from the memory range.
      #
      # @param [Range<Integer>, Integer] addr
      #   The address(es) to read from.
      #
      # @return [MemoryRange, Integer]
      #   If the given address was a Range, then a new MemoryRange will be returned.
      #   If the given address was an Integer, then the word at the given address will be read.
      #
      def [](addr)
        if addr.kind_of?(Range)
          base_addr = @lower + addr.begin

          self.class.new(@memory,base_addr,base_addr + addr.end)
        else
          @memory[@lower + addr]
        end
      end

      #
      # Writes data to the memory range.
      #
      # @param [Range<Integer>, Integer] addr
      #   The address(es) to write to.
      #
      # @param [Range, Array<Integer>, Integer] data
      #   The data to write.
      #
      def []=(addr,data)
        if addr.kind_of?(Range)
          base_addr = @lower + addr.begin

          @memory[(base_addr..(base_addr + addr.end))] = data
        else
          @memory[@lower + addr] = data
        end

        return data
      end

      #
      # Enumerates over the words within the memory range.
      #
      # @yield [word]
      #   The given block will be passed each word in the memory range.
      #
      # @yieldparam [Integer] word
      #   A word read from the memory range.
      #
      # @return [MemoryRange]
      #   The memory range.
      #
      def each
        (@lower..@upper).step(WORD_SIZE).each do |addr|
          yield @memory[addr]
        end

        return self
      end

    end
  end
end
