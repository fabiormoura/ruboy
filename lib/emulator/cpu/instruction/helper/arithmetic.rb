module Emulator
  module Cpu
    module Instruction
      module Helper
        module Arithmetic
          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def increment_byte_register(register:, state:)
            value = state.send(register).read_value
            state.f.toggle_half_carry_flag(value & 0b0000_1111 == 0b0000_1111)

            state.send(register).write_value(value + 1)

            updated_value = state.send(register).read_value

            state.f.toggle_zero_flag(updated_value == 0x0)
            state.f.toggle_subtract_flag(false)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def decrement_byte_register(register:, state:)
            value = state.send(register).read_value
            state.f.toggle_half_carry_flag(value & 0b0001_0000 == 0b0001_0000)

            state.send(register).write_value(value - 1)

            updated_value = state.send(register).read_value

            state.f.toggle_zero_flag(updated_value == 0x0)
            state.f.toggle_subtract_flag(true)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          def increment_word_register(register:, state:)
            value = state.send(register).read_value + 1
            state.send(register).write_value(value)
          end

          def signed_byte_value(value)
            value > 0b0111_1111 ? (value & 0b0111_1111) - 0b1000_0000 : value
          end

          # @param [Symbol] primary_register
          # @param [Symbol] secondary_register
          # @param [::Emulator::Cpu::State] state
          def add_word_registers(primary_register:, secondary_register:, state:)
            primary_value = state.send(primary_register).read_value
            secondary_value = state.send(secondary_register).read_value

            value = primary_value + secondary_value
            u16_value = (primary_value + secondary_value) & 0xFFFF

            state.send(primary_register).write_value(u16_value)

            state.f.toggle_subtract_flag(false)
            state.f.toggle_half_carry_flag((primary_value & 0xFFF) + (secondary_value & 0xFFF) > 0xFFF)
            state.f.toggle_carry_flag(value >> 16 > 0)
          end
        end
      end
    end
  end
end
