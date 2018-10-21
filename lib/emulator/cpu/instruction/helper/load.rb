module Emulator
  module Cpu
    module Instruction
      module Helper
        module Load
          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def load_word_register_from_pc_position_address(register:, state:, mmu:)
            low_value = mmu[state.pc.read_value]
            state.pc.increment
            high_value = mmu[state.pc.read_value]
            state.pc.increment

            state.send(register).write_values(low_value: low_value, high_value: high_value)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def load_byte_register_from_pc_position_address(register:, state:, mmu:)
            value = mmu[state.pc.read_value]
            state.pc.increment

            state.send(register).write_value(value)
          end

          # @param [Symbol] register
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def load_word_register_address_from_a_register(register:, state:, mmu:)
            mmu[state.send(register).read_value] = state.a.read_value
          end
        end
      end
    end
  end
end