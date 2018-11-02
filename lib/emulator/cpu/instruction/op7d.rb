module Emulator
  module Cpu
    module Instruction
      module Op7d
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,L', opcode: 0x7D

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value state.l.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
