module Emulator
  module Cpu
    module Instruction
      module Opf1
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'POP AF', opcode: 0xF1

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          pop_stack_onto_word_register(register: :af, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
