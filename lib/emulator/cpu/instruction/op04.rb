module Emulator
  module Cpu
    module Instruction
      class Op04 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x04), cycles: 4, label: 'INC B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.f.toggle_half_carry_flag(state.b.read_value & 0b0000_1111 == 0b0000_1111)

          state.b.write_value(state.b.read_value + 1)

          state.f.toggle_zero_flag(state.b.read_value == 0x0)
          state.f.toggle_subtract_flag(false)
        end
      end
    end
  end
end
