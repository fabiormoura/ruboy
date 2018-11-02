module Emulator
  module Cpu
    module Instruction
      module Op46
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD B,(HL)', opcode: 0x46

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.b.write_value mmu[state.hl.read_value]
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
