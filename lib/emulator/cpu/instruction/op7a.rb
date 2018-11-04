module Emulator
  module Cpu
    module Instruction
      module Op7a
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,D', opcode: 0x7A

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value state.d.read_value
          RESULT
        end
      end
    end
  end
end
