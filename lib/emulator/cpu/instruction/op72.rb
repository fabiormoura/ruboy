module Emulator
  module Cpu
    module Instruction
      module Op72
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD (HL),D', opcode: 0x72

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          mmu[state.hl.read_value] = state.d.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
