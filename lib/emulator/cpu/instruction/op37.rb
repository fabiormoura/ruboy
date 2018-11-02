module Emulator
  module Cpu
    module Instruction
      module Op37
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'SCF', opcode: 0x37

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.f.toggle_carry_flag(true)
          state.f.toggle_half_carry_flag(false)
          state.f.toggle_subtract_flag(false)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
