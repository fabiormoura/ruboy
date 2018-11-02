module Emulator
  module Cpu
    module Instruction
      module Op4d
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,L', opcode: 0x4D

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.l.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
