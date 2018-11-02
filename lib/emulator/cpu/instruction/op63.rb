module Emulator
  module Cpu
    module Instruction
      module Op63
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD H,E', opcode: 0x63

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.h.write_value state.e.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
