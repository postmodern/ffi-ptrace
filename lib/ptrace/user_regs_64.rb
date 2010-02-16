module FFI
  module PTrace
    module UserRegs64
      def self.included(base)
        base.module_eval do
          layout :r15, :ulong,
            :r14, :ulong,
            :r13, :ulong,
            :r12, :ulong,
            :rbp, :ulong,
            :rbx, :ulong,
            :r11, :ulong,
            :r10, :ulong,
            :r9, :ulong,
            :r8, :ulong,
            :rax, :ulong,
            :rcx, :ulong,
            :rdx, :ulong,
            :rsi, :ulong,
            :rdi, :ulong,
            :orig_rax, :ulong,
            :rip, :ulong,
            :cs, :ulong,
            :eflags, :ulong,
            :rsp, :ulong,
            :ss, :ulong,
            :fs_base, :ulong,
            :gs_base, :ulong,
            :ds, :ulong,
            :es, :ulong,
            :gs, :ulong
        end
      end
    end
  end
end
