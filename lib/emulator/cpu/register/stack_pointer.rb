module Emulator
  module Cpu
    module Register
      class StackPointer < ::Emulator::Cpu::Register::Register
        def initialize(value: 0x0)
          super(size_in_bits: 16, value: value, label: 'SP')
        end

        # @param [Integer] low_value
        # @param [Integer] high_value
        def write_values(low_value:, high_value:)
          write_value((high_value << 8) | low_value)
        end
      end
    end
  end
end