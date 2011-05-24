module FFI
  module PTrace
    module UserFPRegs32
      def self.included(base)
        base.module_eval do
          layout :cwd, :long,
                 :swd, :long,
                 :twd, :long,
                 :fip, :long,
                 :fcs, :long,
                 :foo, :long,
                 :fos, :long,
                 :st_space, [:long, 20]
        end
      end
    end
  end
end
