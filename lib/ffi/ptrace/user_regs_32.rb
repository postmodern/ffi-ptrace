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
    end
  end
end
