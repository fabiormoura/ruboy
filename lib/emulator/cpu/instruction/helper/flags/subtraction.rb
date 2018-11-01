module Emulator
  module Cpu
    module Instruction
      module Helper
        module Flags
          module Subtraction
            class << self
              # @param [::Emulator::Cpu::State] state
              # @param [Integer] operand_value
              # @param [Integer] subtracted_value
              def update_register_flags(state:, operand_value:, subtracted_value:)
                state.f.toggle_zero_flag(subtracted_value == 0x00)
                state.f.toggle_subtract_flag(true)
                state.f.toggle_half_carry_flag((subtracted_value & 0xF) > (state.a.read_value & 0xF))
                state.f.toggle_carry_flag(state.a.read_value < operand_value)
              end
            end
          end
        end
      end
    end
  end
end
