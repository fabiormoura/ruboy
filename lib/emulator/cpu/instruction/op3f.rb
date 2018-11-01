module Emulator
  module Cpu
    module Instruction
      class Op3f < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x3F), cycles: 4, label: 'CCF')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.f.toggle_carry_flag(!state.f.carry_flag_enabled?)
          state.f.toggle_half_carry_flag(false)
          state.f.toggle_subtract_flag(false)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
