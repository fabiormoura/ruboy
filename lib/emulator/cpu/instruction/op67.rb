module Emulator
  module Cpu
    module Instruction
      module Op67
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD H,A', opcode: 0x67

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.h.write_value state.a.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
