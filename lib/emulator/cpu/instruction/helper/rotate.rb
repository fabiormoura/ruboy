module Emulator
  module Cpu
    module Instruction
      module Helper
        module Rotate
          extend ActiveSupport::Concern

          class_methods do
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

            protected :rotate_left_byte_register

            def rotate_left_byte_register_using_carry_flag(register:, state:, reset_zero_flag: true)
              value = state.send(register).read_value
              register_bit = (value >> 7) & 0x01

              carry_bit = state.f.carry_flag_enabled? ? 0x1 : 0x0

              updated_value = value << 1 & 0xFF | carry_bit
              state.send(register).write_value(updated_value)
              state.f.toggle_zero_flag(reset_zero_flag ? false : updated_value == 0x00)
              state.f.toggle_subtract_flag(false)
              state.f.toggle_half_carry_flag(false)
              state.f.toggle_carry_flag(register_bit != 0)
            end

            protected :rotate_left_byte_register_using_carry_flag

            def rotate_right_byte_register_using_carry_flag(register:, state:)
              value = state.send(register).read_value
              register_bit = value & 0x01

              carry_bit = state.f.carry_flag_enabled? ? 0x1 : 0x0

              state.send(register).write_value(value >> 1 & 0xFF | (carry_bit << 7))
              state.f.toggle_zero_flag(false)
              state.f.toggle_subtract_flag(false)
              state.f.toggle_half_carry_flag(false)
              state.f.toggle_carry_flag(register_bit != 0)
            end

            protected :rotate_right_byte_register_using_carry_flag

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

            protected :rotate_right_byte_register
          end
        end
      end
    end
  end
end
