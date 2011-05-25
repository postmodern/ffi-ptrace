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

      def cwd; self[:cwd]; end
      def swd; self[:swd]; end
      def ftw; self[:ftw]; end
      def fop; self[:fop]; end
      def rip; self[:rip]; end
      def rdp; self[:rdp]; end
      def mxcsr; self[:mxcsr]; end
      def mxcr_mask; self[:mxcr_mask]; end
      def st_space; self[:st_space]; end
      def xmm_space; self[:xmm_space]; end
    end
  end
end
