module Emulator
  module Cpu
    module Instruction
      module Op64
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD H,H', opcode: 0x64

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.h.write_value state.h.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
