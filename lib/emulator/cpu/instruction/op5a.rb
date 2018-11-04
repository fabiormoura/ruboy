module Emulator
  module Cpu
    module Instruction
      module Op5a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD E,D', opcode: 0x5A

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.e.write_value state.d.read_value
          RESULT
        end
      end
    end
  end
end
