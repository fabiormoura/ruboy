module Emulator
  module Cpu
    module Instruction
      module Op6e
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,(HL)', opcode: 0x6E

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value mmu[state.hl.read_value]
          RESULT
        end
      end
    end
  end
end
