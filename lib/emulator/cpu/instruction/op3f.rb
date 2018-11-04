module Emulator
  module Cpu
    module Instruction
      module Op3f
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'CCF', opcode: 0x3F

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.f.toggle_carry_flag(!state.f.carry_flag_enabled?)
          state.f.toggle_half_carry_flag(false)
          state.f.toggle_subtract_flag(false)
          RESULT
        end
      end
    end
  end
end
