module Emulator
  module Cpu
    module Instruction
      module Op47
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD B,A', opcode: 0x47

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.b.write_value state.a.read_value
          RESULT
        end
      end
    end
  end
end
