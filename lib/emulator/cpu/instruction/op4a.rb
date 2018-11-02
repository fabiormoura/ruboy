module Emulator
  module Cpu
    module Instruction
      module Op4a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD C,D', opcode: 0x4A

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.c.write_value state.d.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
