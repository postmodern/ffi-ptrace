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
      #   If the given address was a Range, then a new {MemoryRange} will be returned.
      #   If the given address was an Integer, then the word at the given address will be read.
      #
      def [](index,length=1)
        if index.kind_of?(Range)
          base = @lower + index.begin

          @memory[Range.new(base,base+index.end)]
        elsif length > 1
          @memory[@lower + index, length]
        else
          @memory[@lower + index]
        end
      end

      #
      # Writes data to the memory range.
      #
      # @param [Integer] addr
      #   The address(es) to write to.
      #
      # @param [Array<Integer>, String, Integer] data
      #   The data to write.
      #
      def []=(addr,data)
        @memory[addr] = data
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
