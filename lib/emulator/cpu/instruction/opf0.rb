module Emulator
  module Cpu
    module Instruction
      module Opf0
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LDH A,(a8)', opcode: 0xF0

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          address_offset = mmu[state.pc.read_value]
          state.pc.increment
          state.a.write_value mmu[0xFF00 + address_offset]
          RESULT
        end
      end
    end
  end
end
