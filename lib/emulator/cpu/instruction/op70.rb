module Emulator
  module Cpu
    module Instruction
      module Op70
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD (HL),B', opcode: 0x70

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          mmu[state.hl.read_value] = state.b.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
