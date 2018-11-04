module Emulator
  module Cpu
    module Instruction
      module Op75
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD (HL),L', opcode: 0x75

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          mmu[state.hl.read_value] = state.l.read_value
          RESULT
        end
      end
    end
  end
end
