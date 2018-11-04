module Emulator
  module Cpu
    module Instruction
      module Op0a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,(BC)', opcode: 0x0A

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value mmu[state.bc.read_value]
          RESULT
        end
      end
    end
  end
end
