module Emulator
  module Cpu
    module Instruction
      module Op0a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,(BC)', opcode: 0x0A

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value mmu[state.bc.read_value]
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
