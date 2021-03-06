module Emulator
  module Cpu
    module Instruction
      module Op0b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'DEC BC', opcode: 0x0B

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.bc.write_value(state.bc.read_value - 1)
          RESULT
        end
      end
    end
  end
end
