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

      def r14; self[:r14]; end
      def r13; self[:r13]; end
      def r12; self[:r12]; end
      def rbp; self[:rbp]; end
      def rbx; self[:rbx]; end
      def r11; self[:r11]; end
      def r10; self[:r10]; end
      def r9; self[:r9]; end
      def r8; self[:r8]; end
      def rax; self[:rax]; end
      def rcx; self[:rcx]; end
      def rdx; self[:rdx]; end
      def rsi; self[:rsi]; end
      def rdi; self[:rdi]; end
      def orig_rax; self[:orig_rax]; end
      def rip; self[:rip]; end
      def cs; self[:cs]; end
      def elfags; self[:eflags]; end
      def rsp; self[:rsp]; end
      def ss; self[:ss]; end
      def fs_base; self[:fs_base]; end
      def gs_base; self[:gs_base]; end
      def ds; self[:ds]; end
      def es; self[:es]; end
      def gs; self[:gs]; end
  end
end
