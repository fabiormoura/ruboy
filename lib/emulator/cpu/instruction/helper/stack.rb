module Emulator
  module Cpu
    module Instruction
      module Helper
        module Stack
          extend ActiveSupport::Concern

          class_methods do
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

            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def pop_stack_onto_word_register(register:, state:, mmu:)
              state.send(register).write_values(low_value: mmu[state.sp.read_value], high_value: mmu[state.sp.read_value + 1])
              state.sp.write_value(state.sp.read_value + 2)
            end

            protected :pop_stack_onto_word_register
          end
        end
      end
    end
  end
end
