module Emulator
  module Cpu
    module Instruction
      module Opd1
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'POP DE', opcode: 0xD1

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          pop_stack_onto_word_register(register: :de, state: state, mmu: mmu)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 12)
        end
      end
    end
  end
end
