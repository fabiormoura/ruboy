module Emulator
  module Cpu
    module Instruction
      module Op4b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,E', opcode: 0x4B

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.e.read_value
          RESULT
        end
      end
    end
  end
end
