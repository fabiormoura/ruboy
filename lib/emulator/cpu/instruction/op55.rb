module Emulator
  module Cpu
    module Instruction
      module Op55
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,L', opcode: 0x55

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value state.l.read_value
          RESULT
        end
      end
    end
  end
end
