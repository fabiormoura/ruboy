module Emulator
  module Cpu
    module Instruction
      module Op6d
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,L', opcode: 0x6D

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value state.l.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
