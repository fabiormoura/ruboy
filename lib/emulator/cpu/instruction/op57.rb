module Emulator
  module Cpu
    module Instruction
      module Op57
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD D,A', opcode: 0x57

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.d.write_value state.a.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
