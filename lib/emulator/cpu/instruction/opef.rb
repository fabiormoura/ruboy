module Emulator
  module Cpu
    module Instruction
      module Opef
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        mnemonic_definition 'RST 28H', opcode: 0xEF

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 16).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          push_word_value_onto_stack(value: state.pc.read_value, state: state, mmu: mmu)
          state.pc.write_value(0x28)
          RESULT
        end
      end
    end
  end
end
