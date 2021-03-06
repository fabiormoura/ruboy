module Emulator
  module Cpu
    module Instruction
      module Op4f
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,A', opcode: 0x4F

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.a.read_value
          RESULT
        end
      end
    end
  end
end
