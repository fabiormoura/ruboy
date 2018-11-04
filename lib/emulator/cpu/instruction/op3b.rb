module Emulator
  module Cpu
    module Instruction
      module Op3b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'DEC SP', opcode: 0x3B

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.sp.write_value((state.sp.read_value - 1) & 0xFFFF)
          RESULT
        end
      end
    end
  end
end
