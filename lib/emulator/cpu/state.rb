module Emulator
  module Cpu
    class State
      attr_reader :a, :b, :c, :d, :e, :f, :h, :l, :af, :bc, :de, :hl, :pc, :sp

      def initialize
        @a = ::Emulator::Cpu::Register::Byte.new(label: 'A')
        @b = ::Emulator::Cpu::Register::Byte.new(label: 'B')
        @c = ::Emulator::Cpu::Register::Byte.new(label: 'C')
        @d = ::Emulator::Cpu::Register::Byte.new(label: 'D')
        @e = ::Emulator::Cpu::Register::Byte.new(label: 'E')
        @f = ::Emulator::Cpu::Register::Flags.new
        @h = ::Emulator::Cpu::Register::Byte.new(label: 'H')
        @l = ::Emulator::Cpu::Register::Byte.new(label: 'L')
        @pc = ::Emulator::Cpu::Register::ProgramCounter.new
        @sp = ::Emulator::Cpu::Register::StackPointer.new

        @af = ::Emulator::Cpu::Register::Word.new(low_register: @f, high_register: @a)
        @bc = ::Emulator::Cpu::Register::Word.new(low_register: @c, high_register: @b)
        @de = ::Emulator::Cpu::Register::Word.new(low_register: @e, high_register: @d)
        @hl = ::Emulator::Cpu::Register::Word.new(low_register: @l, high_register: @h)
      end

      def ==(other)
        return false unless other.is_a?(::Emulator::Cpu::State) && other.class == self.class
        @a == other.a &&
            @b == other.b &&
            @c == other.c &&
            @d == other.d &&
            @e == other.e &&
            @f == other.f &&
            @h == other.h &&
            @l == other.l &&
            @pc == other.pc &&
            @sp == other.sp
      end

      def to_s
        <<TEXT
        CPU STATE
        #{@a}
        #{@b}
        #{@c}
        #{@d}
        #{@e}
        #{@f}
        #{@h}
        #{@l}
        #{@pc}
        #{@sp}
TEXT
      end
    end
  end
end