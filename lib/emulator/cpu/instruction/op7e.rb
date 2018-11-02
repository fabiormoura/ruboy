module Emulator
  module Cpu
    module Instruction
      module Op7e
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD A,(HL)', opcode: 0x7E

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value mmu[state.hl.read_value]
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
