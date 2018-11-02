module Emulator
  module Cpu
    module Instruction
      module Op6f
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD L,A', opcode: 0x6F

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.l.write_value state.a.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
