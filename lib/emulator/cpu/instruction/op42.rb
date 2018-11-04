module Emulator
  module Cpu
    module Instruction
      module Op42
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD B,D', opcode: 0x42

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.b.write_value state.d.read_value
          RESULT
        end
      end
    end
  end
end
