module Emulator
  module Cpu
    module Instruction
      module Op5d
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,L', opcode: 0x5D

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.l.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
