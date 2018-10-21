module Emulator
  module Cpu
    module Register
      class StackPointer < ::Emulator::Cpu::Register::Register
        def initialize(value: 0x0)
          super(size_in_bits: 16, value: value, label: 'SP')
        end
      end
    end
  end
end