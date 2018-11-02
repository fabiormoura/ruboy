module Emulator
  module Cpu
    module Instruction
      module Op59
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,C', opcode: 0x59

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.c.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
