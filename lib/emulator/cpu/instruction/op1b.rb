module Emulator
  module Cpu
    module Instruction
      module Op1b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'DEC DE', opcode: 0x1B

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.de.write_value(state.de.read_value - 1)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
