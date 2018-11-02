module Emulator
  module Cpu
    module Instruction
      module Op4c
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,H', opcode: 0x4C

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.h.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
