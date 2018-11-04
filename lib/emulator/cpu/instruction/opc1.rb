module Emulator
  module Cpu
    module Instruction
      module Opc1
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'POP BC', opcode: 0xC1

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          pop_stack_onto_word_register(register: :bc, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
