module Emulator
  module Cpu
    module Instruction
      class Ope1 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xE1), cycles: 12, label: 'POP HL')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          pop_stack_onto_word_register(register: :hl, state: state, mmu: mmu)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 12)
        end
      end
    end
  end
end
