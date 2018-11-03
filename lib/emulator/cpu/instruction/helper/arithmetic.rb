module Emulator
  module Cpu
    module Instruction
      module Helper
        module Arithmetic
          extend ActiveSupport::Concern

          class_methods do
            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            def increment_byte_register(register:, state:)
              value = state.send(register).read_value

              state.send(register).write_value(value + 1)

              updated_value = state.send(register).read_value
              ::Emulator::Cpu::Instruction::Helper::Flags::Increment.update_register_flags(state: state, value: value, updated_value: updated_value)
            end

            protected :increment_byte_register

            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            def decrement_byte_register(register:, state:)
              value = state.send(register).read_value
              updated_value = (value - 1) & 0xFF

              state.send(register).write_value(updated_value)

              ::Emulator::Cpu::Instruction::Helper::Flags::Decrement.update_register_flags(state: state, value: value, updated_value: updated_value)
            end

            protected :decrement_byte_register

            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            def increment_word_register(register:, state:)
              value = state.send(register).read_value + 1
              state.send(register).write_value(value)
            end

            protected :increment_word_register

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

            protected :add_word_registers

            # @param [Symbol] register
            # @param [Integer] operand_value
            # @param [::Emulator::Cpu::State] state
            def add_value_to_byte_register(register:, operand_value:, state:)
              register_value = state.send(register).read_value

              value = register_value + operand_value
              u8_value = (register_value + operand_value) & 0xFF

              state.a.write_value(u8_value)

              state.f.toggle_subtract_flag(false)
              state.f.toggle_half_carry_flag((register_value & 0xF) + (operand_value & 0xF) > 0xF)
              state.f.toggle_carry_flag(value >> 8 > 0)
            end

            protected :add_value_to_byte_register

            # @param [Symbol] register
            # @param [Integer] value
            # @param [::Emulator::Cpu::State] state
            def xor_byte_register(register:, value:, state:)
              updated_value = state.send(register).read_value ^ value
              state.send(register).write_value(updated_value)
              ::Emulator::Cpu::Instruction::Helper::Flags::Xor.update_register_flags(state: state, value: updated_value)
            end

            protected :xor_byte_register

            # @param [Symbol] register
            # @param [Integer] value
            # @param [::Emulator::Cpu::State] state
            def or_byte_register(register:, value:, state:)
              updated_value = state.send(register).read_value | value
              state.send(register).write_value(updated_value)
              ::Emulator::Cpu::Instruction::Helper::Flags::Or.update_register_flags(state: state, value: updated_value)
            end

            protected :or_byte_register
          end
        end
      end
    end
  end
end
