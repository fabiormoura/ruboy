module Emulator
  module Cpu
    module Instruction
      module Op7c
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,H', opcode: 0x7C

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value state.h.read_value
          RESULT
        end
      end
    end
  end
end
