module Emulator
  module Cpu
    module Instruction
      module Op7b
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,E', opcode: 0x7B

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value state.e.read_value
          RESULT
        end
      end
    end
  end
end
