module Emulator
  module Cpu
    module Instruction
      module Opc3
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR a16', opcode: 0xC3

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 16).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_immediate_word_value(state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
