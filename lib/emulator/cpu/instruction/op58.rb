module Emulator
  module Cpu
    module Instruction
      module Op58
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,B', opcode: 0x58

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.b.read_value
          RESULT
        end
      end
    end
  end
end
