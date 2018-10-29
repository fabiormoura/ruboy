module Emulator
  module Cpu
    module Instruction
      class Opd1 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xD1), cycles: 12, label: 'POP DE')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          pop_stack_onto_word_register(register: :de, state: state, mmu: mmu)
        end
      end
    end
  end
end
