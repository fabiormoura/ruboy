module Emulator
  module Cpu
    module Instruction
      module Op71
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD (HL),C', opcode: 0x71

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          mmu[state.hl.read_value] = state.c.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
