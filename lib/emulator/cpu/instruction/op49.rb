module Emulator
  module Cpu
    module Instruction
      module Op49
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,C', opcode: 0x49

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.c.read_value
          RESULT
        end
      end
    end
  end
end
