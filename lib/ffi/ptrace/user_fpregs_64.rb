module FFI
  module PTrace
    module UserFPRegs64
      def self.included(base)
        base.module_eval do
          layout :cwd, :uint16,
                 :swd, :uint16,
                 :ftw, :uint16,
                 :fop, :uint16,
                 :rip, :uint64,
                 :rdp, :uint64,
                 :mxcsr, :uint32,
                 :mxcr_mask, :uint32,
                 :st_space, [:uint32, 32],
                 :xmm_space, [:uint32, 64],
                 :padding, [:uint32, 24]
        end
      end
    end
  end
end
