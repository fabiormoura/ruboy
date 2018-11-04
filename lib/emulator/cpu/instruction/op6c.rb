module Emulator
  module Cpu
    module Instruction
      module Op6c
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,H', opcode: 0x6C

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value state.h.read_value
          RESULT
        end
      end
    end
  end
end
