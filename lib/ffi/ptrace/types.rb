require 'ffi'

module FFI
  module PTrace
    extend FFI::Library

    WORD_SIZE = (FFI::Platform::ADDRESS_SIZE / 8)

    ENDIANNESS = if (FFI::Platform::LITTLE_ENDIAN == 1234)
                   :little
                 else
                   :big
                 end

    # Operation not permitted
    EPERM = 1

    # No such process
    ESRCH = 3

    # I/O error
    EIO = 5
  end
end
