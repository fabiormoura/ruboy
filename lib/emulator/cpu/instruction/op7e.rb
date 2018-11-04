module Emulator
  module Cpu
    module Instruction
      module Op7e
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,(HL)', opcode: 0x7E

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value mmu[state.hl.read_value]
          RESULT
        end
      end
    end
  end
end
