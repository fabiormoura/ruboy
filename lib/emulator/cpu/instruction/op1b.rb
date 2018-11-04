module Emulator
  module Cpu
    module Instruction
      module Op1b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'DEC DE', opcode: 0x1B

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.de.write_value(state.de.read_value - 1)
          RESULT
        end
      end
    end
  end
end
