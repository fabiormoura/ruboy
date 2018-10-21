module Emulator
  module Cpu
    module Instruction
      module Helper
        module Move
          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def move_word_register_from_d16(register:, state:, mmu:)
            low_value = mmu[state.pc.read_value]
            state.pc.increment
            high_value = mmu[state.pc.read_value]
            state.pc.increment

            state.send(register).write_values(low_value: low_value, high_value: high_value)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def move_byte_register_from_d8(register:, state:, mmu:)
            value = mmu[state.pc.read_value]
            state.pc.increment

            state.send(register).write_value(value)
          end
        end
      end
    end
  end
end
