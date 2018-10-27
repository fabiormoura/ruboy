module Emulator
  module Cpu
    module Instruction
      module Helper
        module Flags
          module Increment
            class << self
              # @param [::Emulator::Cpu::State] state
              # @param [Integer] value
              # @param [Integer] updated_value
              def update_register_flags(state:, value:, updated_value:)
                state.f.toggle_half_carry_flag(value & 0b0000_1111 == 0b0000_1111)
                state.f.toggle_zero_flag(updated_value == 0x0)
                state.f.toggle_subtract_flag(false)
              end
            end

          end
        end
      end
    end
  end
end
