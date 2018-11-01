module Emulator
  module Cpu
    module Instruction
      class Opd5 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xD5), cycles: 16, label: 'PUSH DE')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          push_word_value_onto_stack(value: state.de.read_value, state: state, mmu: mmu)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 16)
        end
      end
    end
  end
end
