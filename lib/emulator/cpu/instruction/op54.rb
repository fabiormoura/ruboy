module Emulator
  module Cpu
    module Instruction
      module Op54
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,H', opcode: 0x54

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value state.h.read_value
          RESULT
        end
      end
    end
  end
end
