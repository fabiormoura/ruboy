module Emulator
  module Cpu
    module Instruction
      module Op68
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,B', opcode: 0x68

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value state.b.read_value
          RESULT
        end
      end
    end
  end
end
