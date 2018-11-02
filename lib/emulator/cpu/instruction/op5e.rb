module Emulator
  module Cpu
    module Instruction
      module Op5e
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,(HL)', opcode: 0x5E

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value mmu[state.hl.read_value]
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
