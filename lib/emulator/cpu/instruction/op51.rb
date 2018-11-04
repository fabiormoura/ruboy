module Emulator
  module Cpu
    module Instruction
      module Op51
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,C', opcode: 0x51

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value state.c.read_value
          RESULT
        end
      end
    end
  end
end
