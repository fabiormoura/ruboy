module Emulator
  module Cpu
    module Instruction
      module Op62
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD H,D', opcode: 0x62

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.h.write_value state.d.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
