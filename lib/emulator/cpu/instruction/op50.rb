module Emulator
  module Cpu
    module Instruction
      module Op50
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,B', opcode: 0x50

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value state.b.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
