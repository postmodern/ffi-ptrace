require 'ffi/ptrace/types'
require 'ffi/ptrace/process'
require 'ffi/ptrace/memory_range'

module FFI
  module PTrace
    class Memory

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
      def initialize(process)
        @process = process
      end

      #
      # Reads memory from the process.
      #
      # @param [Range<Integer>, Integer] address
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
      def [](address,length=nil)
        if address.kind_of?(Range)
          MemoryRange.new(self,address.begin,(address.end - address.begin))
        elsif length
          MemoryRange.new(self,address,length)
        else
          get_word(address)
        end
      end

      #
      # Writes the value to the memory of a process.
      #
      # @param [Integer] address
      #   The base address to begin writing at.
      #
      # @param [String, Float, Integer] value
      #   The value to write.
      #
      def []=(address,value)
        case value
        when String
          self[address,value.length].put_bytes(0,value)
        when Float
        when Integer
          if (value >= 0 && value <= 0xff)
            put_uint8(address,value)
          elsif (value >= 0x100 && value <= 0xffff)
            put_uint16(address,value)
          elsif (value >= 0x10000 && value <= 0xffffffff)
            put_uint32(address,value)
          elsif (value >= 0x100000000 && value <= 0xffffffffffffffff)
            put_uint64(address,value)
          end

          put_word(address,value)
        else
          raise(TypeError,"value must be a String, Float or Integer")
        end

        return value
      end

      #
      # @abstract
      #
      def get_word(address)
        raise(NotImplemented,"get_word not implemented in #{self.class}")
      end

      #
      # @abstract
      #
      def put_word(address,value)
        raise(NotImplemented,"put_word not implemented in #{self.class}")
      end

      def get_int(address)
        read(address,:int)
      end

      def put_int(address,value)
        write(address,:int,value)
      end

      def get_int8(address)
        read(address,:int8)
      end

      def put_int8(address,value)
        write(address,:int8,value)
      end

      def get_char(address)
        read(address,:char)
      end

      def put_char(address,value)
        write(address,:char,value)
      end

      def get_int16(address)
        read(address,:int16)
      end

      alias get_short get_int16

      def put_int16(address,value)
        write(address,:int16,value)
      end

      alias put_short put_int16

      def get_int32(address)
        read(address,:int32)
      end

      alias get_long get_int32

      def put_int32(address,value)
        write(address,:int32,value)
      end

      alias put_long put_int32

      def get_int64(address)
        read(address,:int64)
      end

      alias get_long_long get_int64

      def put_int64(address,value)
        write(address,:int64,value)
      end

      alias put_long_long put_int64

      def get_float(address)
        read(address,:float)
      end

      def put_float(address,value)
        write(address,:float,value)
      end

      def get_double(address)
        read(address,:double)
      end

      def put_double(address,value)
        write(address,:double,value)
      end

      def get_uint(address)
        read(address,:uint)
      end

      def put_uint(address,value)
        write(address,:uint,value)
      end

      def get_uint8(address)
        read(address,:uint8)
      end

      def put_uint8(address,value)
        write(address,:uint8,value)
      end

      def get_uchar(address)
        read(address,:uchar)
      end

      alias get_byte get_uchar

      def put_uchar(address,value)
        write(address,:uchar,value)
      end

      alias put_byte put_uchar

      def get_uint16(address)
        read(address,:uint16)
      end

      alias get_ushort get_uint16

      def put_uint16(address,value)
        write(address,:uint16,value)
      end

      alias put_ushort put_uint16

      def get_uint32(address)
        read(address,:uint32)
      end

      alias get_ulong get_uint32

      def put_uint32(address,value)
        write(address,:uint32,value)
      end

      alias put_ulong put_uint32

      def get_uint64(address)
        read(address,:uint64)
      end

      alias get_ulong_long get_uint64

      def put_uint64(address,value)
        write(address,:uint64,value)
      end

      def get_array_of_int(address,length)
        self[address, length * FFI.type_size(:int)].get_array_of_int
      end

      def get_array_of_int8(address,length)
        self[address, length * FFI.type_size(:int8)].get_array_of_int8
      end

      def get_array_of_char(address,length)
        self[address, length * FFI.type_size(:char)].get_array_of_char
      end

      def get_array_of_int16(address,length)
        self[address, length * FFI.type_size(:int16)].get_array_of_int16
      end

      alias get_array_of_short get_array_of_int16

      def get_array_of_int32(address,length)
        self[address, length * FFI.type_size(:int32)].get_array_of_int32
      end

      alias get_array_of_long get_array_of_int32

      def get_array_of_int64(address,length)
        self[address, length * FFI.type_size(:int64)].get_array_of_int64
      end

      alias get_array_of_long_long get_array_of_int64

      def get_array_of_float(address,length)
        self[address, length * FFI.type_size(:float)].get_array_of_float
      end

      def get_array_of_double(address,length)
        self[address, length * FFI.type_size(:double)].get_array_of_double
      end

      def get_array_of_uint(address,length)
        self[address, length * FFI.type_size(:uint)].get_array_of_uint
      end

      def get_array_of_uint8(address,length)
        self[address, length * FFI.type_size(:uint)].get_array_of_uint8
      end

      def get_array_of_uint16(address,length)
        self[address, length * FFI.type_size(:uint16)].get_array_of_uint16
      end

      alias get_array_of_ushort get_array_of_uint16

      def get_array_of_uint32(address,length)
        self[address, length * FFI.type_size(:uint32)].get_array_of_uint32
      end

      alias get_array_of_ulong get_array_of_uint32

      def get_array_of_uint64(address,length)
        self[address, length * FFI.type_size(:uint64)].get_array_of_uint64
      end

      alias get_array_of_ulong_long get_array_of_uint64

      protected

      def self.buffers
        Thread.current[:ffi_ptrace_buffers] ||= {}
      end

      def buffer
        self.class.buffers[self] ||= FFI::Buffer.new(8)
      end

      def read(address,type)
        size = FFI.find_type(type).size

        # populate the buffer
        (0...size).step(WORD_SIZE) do |offset|
          buffer.put_ulong(offset,get_word(address + offset))
        end

        # deserialize the value
        return buffer.send("get_#{type}",0)
      end

      def write(address,type,value)
        size = FFI.find_type(type).size

        if size < WORD_SIZE
          # populate the buffer before writing into it
          buffer.put_ulong(0,get_word(address))
        end

        # serialize the value
        buffer.send("put_#{type}",0,value)

        # write the buffer back
        (0...size).step(WORD_SIZE) do |offset|
          put_word(address + offset, buffer.get_ulong(offset))
        end

        return self
      end

    end
  end
end
