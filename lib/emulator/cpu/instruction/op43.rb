module Emulator
  module Cpu
    module Instruction
      module Op43
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD B,E', opcode: 0x43

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.b.write_value state.e.read_value
          RESULT
        end
      end
    end
  end
end
