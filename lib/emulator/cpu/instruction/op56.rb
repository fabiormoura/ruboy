module Emulator
  module Cpu
    module Instruction
      module Op56
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,(HL)', opcode: 0x56

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value mmu[state.hl.read_value]
          RESULT
        end
      end
    end
  end
end
