module Emulator
  module Cpu
    module Instruction
      module Op00
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'NOP', opcode: 0x00

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
