module Emulator
  module Cpu
    module Instruction
      module Op1a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,(DE)', opcode: 0x1A

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value mmu[state.de.read_value]
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
