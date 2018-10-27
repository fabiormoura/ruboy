module Emulator
  module Cpu
    module Instruction
      class Op37 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x37), cycles: 4, label: 'SCF')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.f.toggle_carry_flag(true)
          state.f.toggle_half_carry_flag(false)
          state.f.toggle_subtract_flag(false)
        end
      end
    end
  end
end
