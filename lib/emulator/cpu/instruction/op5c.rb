module Emulator
  module Cpu
    module Instruction
      module Op5c
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,H', opcode: 0x5C

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.h.read_value
          RESULT
        end
      end
    end
  end
end
