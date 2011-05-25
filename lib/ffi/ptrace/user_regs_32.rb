module FFI
  module PTrace
    module UserRegs32
      def self.included(base)
        base.module_eval do
          layout :ebx, :long,
            :ecx, :long,
            :edx, :long,
            :esi, :long,
            :edi, :long,
            :ebp, :long,
            :eax, :long,
            :xds, :long,
            :xes, :long,
            :xfs, :long,
            :xgs, :long,
            :orig_eax, :long,
            :eip, :long,
            :xcs, :long,
            :eflags, :long,
            :esp, :long,
            :xss, :long
        end
      end

      def ecx; self[:ecx]; end
      def edx; self[:edx]; end
      def esi; self[:esi]; end
      def edi; self[:edi]; end
      def ebp; self[:ebp]; end
      def eax; self[:eax]; end
      def xds; self[:xds]; end
      def xes; self[:xes]; end
      def xfs; self[:xfs]; end
      def xgs; self[:xgs]; end
      def orig_eax; self[:orig_eax]; end
      def eip; self[:eip]; end
      def xcs; self[:xcs]; end
      def eflags; self[:eflags]; end
      def esp; self[:esp]; end
      def xss; self[:xss]; end
    end
  end
end
