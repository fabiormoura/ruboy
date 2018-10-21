module Emulator
  module Cpu
    module Instruction
      module Helper
        module Rotate
          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def rotate_left_byte_register(register:, state:)
            value = state.send(register).read_value
            bit = (value >> 7) & 1

            state.send(register).write_value(value << 1 & 0xFF | bit)
            state.f.toggle_zero_flag(false)
            state.f.toggle_subtract_flag(false)
            state.f.toggle_half_carry_flag(false)
            state.f.toggle_carry_flag(bit != 0)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def rotate_right_byte_register(register:, state:)
            value = state.send(register).read_value
            bit = value & 1

            state.send(register).write_value(value >> 1 | (bit << 7))
            state.f.toggle_zero_flag(false)
            state.f.toggle_subtract_flag(false)
            state.f.toggle_half_carry_flag(false)
            state.f.toggle_carry_flag(bit != 0)
          end
        end
      end
    end
  end
end
