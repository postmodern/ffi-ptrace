require 'ffi/ptrace/types'

module FFI
  module PTrace
    class MemoryRange < FFI::Buffer

      PAGE_SIZE = 4096

      # The memory that the range came from.
      attr_reader :memory

      # Address the memory starts at.
      attr_reader :address

      # The length of the memory.
      attr_reader :length

      def initialize(memory,address,size)
        @memory    = memory
        @address   = address.to_i
        @length    = size
        @remainder = if size < WORD_SIZE
                       WORD_SIZE - size
                     else
                       size % WORD_SIZE
                     end

        super(@length + @remainder)

        load()
      end

      def load(range=(0..@length))
        align(range).step(WORD_SIZE) do |offset|
          put_ulong(offset,@memory.get_word(@address + offset))
        end

        return self
      end

      alias reload load

      def save(range=(0..@length))
        align(range).step(WORD_SIZE) do |offset|
          @memory.put_ulong(@address + offset,get_uint(offset))
        end

        return self
      end

      def get_bytes(offset=0,count=@length)
        super(offset,count)
      end

      def get_string(offset=0)
        super(offset)
      end

      def get_array_of_char(offset=0,count=@length)
        super(offset,count)
      end

      def get_array_of_int(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:int)))
      end

      def get_array_of_int8(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:int8)))
      end

      def get_array_of_int16(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:int16)))
      end

      def get_array_of_int32(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:int32)))
      end

      def get_array_of_int64(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:int64)))
      end

      def get_array_of_float(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:float)))
      end

      def get_array_of_float32(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:float32)))
      end

      def get_array_of_float64(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:float64)))
      end

      def get_array_of_double(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:double)))
      end

      def get_array_of_uchar(offset=0,count=@length)
        super(offset,count)
      end

      def get_array_of_uint(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:uint)))
      end

      def get_array_of_uint8(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:uint8)))
      end

      def get_array_of_uint16(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:uint16)))
      end

      def get_array_of_uint32(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:uint32)))
      end

      def get_array_of_uint64(offset=0,count=nil)
        super(offset,count || (@length / FFI.type_size(:uint64)))
      end

      protected

      #
      # Aligns a memory range on {WORD_SIZE} boundries.
      #
      # @param [Range] range
      #   The memory range to align.
      #
      # @return [Range]
      #   A memory range aligned on {WORD_SIZE} boundries.
      #
      def align(range)
        start = range.begin - (range.begin % WORD_SIZE)
        stop  = range.end   + ((size - range.end) % WORD_SIZE)

        return (start...stop)
      end

    end
  end
end
