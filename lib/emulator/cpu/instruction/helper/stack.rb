module Emulator
  module Cpu
    module Instruction
      module Helper
        module Stack
          extend ActiveSupport::Concern

          # @param [Integer] value
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def push_word_value_onto_stack(value:, state:, mmu:)
            state.sp.write_value(state.sp.read_value - 1)
            mmu[state.sp.read_value] = (value >> 8) & 0xFF

            state.sp.write_value(state.sp.read_value - 1)
            mmu[state.sp.read_value] = (value & 0xFF)
          end

          protected :push_word_value_onto_stack
        end
      end
    end
  end
end
