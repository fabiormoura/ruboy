module Emulator
  module Cpu
    module Instruction
      class Opfe < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xFE), cycles: 8, label: 'CP d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          value = mmu[state.pc.read_value]
          updated_value = state.a.read_value - value
          state.pc.increment

          state.f.toggle_zero_flag(updated_value == 0x00)
          state.f.toggle_subtract_flag(true)
          state.f.toggle_half_carry_flag((updated_value & 0xF) > (state.a.read_value & 0xF))
          state.f.toggle_carry_flag(state.a.read_value < value)
        end
      end
    end
  end
end
