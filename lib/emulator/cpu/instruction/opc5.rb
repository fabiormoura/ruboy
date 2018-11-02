module Emulator
  module Cpu
    module Instruction
      module Opc5
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'PUSH BC', opcode: 0xC5

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          push_word_value_onto_stack(value: state.bc.read_value, state: state, mmu: mmu)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 16)
        end
      end
    end
  end
end
