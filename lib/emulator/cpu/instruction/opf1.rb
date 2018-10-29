module Emulator
  module Cpu
    module Instruction
      class Opf1 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xF1), cycles: 12, label: 'POP AF')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          pop_stack_onto_word_register(register: :af, state: state, mmu: mmu)
        end
      end
    end
  end
end
