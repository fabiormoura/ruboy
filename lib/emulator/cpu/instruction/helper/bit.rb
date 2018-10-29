module Emulator
  module Cpu
    module Instruction
      module Helper
        module Bit
          extend ActiveSupport::Concern

          # @param [Integer] bit
          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def bit_test_byte_register(bit:, register:, state:)
            state.f.toggle_zero_flag(state.send(register).read_value >> bit == 0)
            state.f.toggle_subtract_flag(false)
            state.f.toggle_half_carry_flag(true)
          end

          protected :bit_test_byte_register
        end
      end
    end
  end
end
