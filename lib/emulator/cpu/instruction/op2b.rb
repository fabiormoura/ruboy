module Emulator
  module Cpu
    module Instruction
      module Op2b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'DEC HL', opcode: 0x2B

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.hl.write_value(state.hl.read_value - 1)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
