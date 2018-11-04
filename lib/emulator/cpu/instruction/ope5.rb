module Emulator
  module Cpu
    module Instruction
      module Ope5
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'PUSH HL', opcode: 0xE5

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 16).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          push_word_value_onto_stack(value: state.hl.read_value, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
