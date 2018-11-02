module Emulator
  module Cpu
    module Instruction
      module Op7b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,E', opcode: 0x7B

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value state.e.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
