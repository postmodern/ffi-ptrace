require 'ffi/ptrace/types'
require 'ffi/ptrace/process'
require 'ffi/ptrace/memory_range'

module FFI
  module PTrace
    class MemorySpace

      #
      # Creates a new memory space.
      #
      # @param [Process] process
      #   The process who's memory that will be accessed.
      #
      # @param [Symbol] read_method
      #   The method to call from the process to read memory.
      #
      # @param [Symbol] write_method
      #   The method to call from the process to write memory.
      #
      def initialize(process,read_method,write_method)
        @process = process
        @read_method = read_method
        @write_method = write_method
      end

      #
      # Reads memory from the process.
      #
      # @param [Range<Integer>, Integer] addr
      #   The address(es) to read from.
      #
      # @param [Integer] length
      #   The number of words to read.
      #
      # @return [MemoryRange, Array<Integer>, Integer]
      #   If the address was a `Range` then a {MemoryRange} object will be returned.
      #   If a length was given, a {MemoryRange} will be returned.
      #   If the address was an Integer, a single word will be returned.
      #
      def [](addr,length=1)
        if addr.kind_of?(Range)
          MemoryRange.new(self,addr.begin,addr.end)
        elsif length > 1
          MemoryRange.new(self,addr,addr + (WORD_SIZE * index))
        else
          @process.send(@read_method,addr)
        end
      end

      #
      # Writes data to the memory of a process.
      #
      # @param [Range, Integer] addr
      #   The address(es) to write data to.
      #
      # @param [Range, Array<Integer>, Integer] data
      #   The data to write.
      #
      # @return [Range, Array<Integer>, Integer]
      #   The written data.
      #
      def []=(addr,data)
        if addr.kind_of?(Range)
          if (data.kind_of?(Array) || data.kind_of?(Range))
            data.each_with_index do |element,index|
              @process.send(@write_method,addr.begin + (index * WORD_SIZE),element)
            end
          else
            addr.step(WORD_SIZE).each do |index|
              @process.send(@write_method,index,data)
            end
          end
        else
          @process.send(@write_method,addr,data)
        end

        return data
      end

    end
  end
end
