module Emulator
  module Cpu
    module Instruction
      module Helper
        module Arithmetic
          # @param [::Emulator::Cpu::Register::Byte] register
          # @param [::Emulator::Cpu::State] state
          def increment_byte_register(register:, state:)
            value = state.send(register).read_value
            state.f.toggle_half_carry_flag(value & 0b0000_1111 == 0b0000_1111)

            state.send(register).write_value(value + 1)

            updated_value = state.send(register).read_value

            state.f.toggle_zero_flag(updated_value == 0x0)
            state.f.toggle_subtract_flag(false)
          end
        end
      end
    end
  end
end