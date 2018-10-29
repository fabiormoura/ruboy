module Emulator
  module Cpu
    module Instruction
      class Opc1 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xC1), cycles: 12, label: 'POP BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          pop_stack_onto_word_register(register: :bc, state: state, mmu: mmu)
        end
      end
    end
  end
end
