module Emulator
  module Cpu
    module Instruction
      module Helper
        module Flags
          module Or
            class << self
              # @param [::Emulator::Cpu::State] state
              # @param [Integer] value
              def update_register_flags(state:, value:)
                state.f.toggle_zero_flag(value == 0x0)
                state.f.toggle_subtract_flag(false)
                state.f.toggle_half_carry_flag(false)
                state.f.toggle_carry_flag(false)
              end
            end
          end
        end
      end
    end
  end
end
