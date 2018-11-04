module Emulator
  module Cpu
    module Instruction
      module Op5d
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,L', opcode: 0x5D

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.l.read_value
          RESULT
        end
      end
    end
  end
end
