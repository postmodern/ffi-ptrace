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

      def cwd; self[:cwd]; end
      def swd; self[:swd]; end
      def twd; self[:twd]; end
      def fip; self[:fip]; end
      def fcs; self[:fcs]; end
      def foo; self[:foo]; end
      def fos; self[:fos]; end
      def st_space; self[:st_space]; end
    end
  end
end
