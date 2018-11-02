module Emulator
  module Cpu
    module Instruction
      module Op6b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,E', opcode: 0x6B

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value state.e.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
