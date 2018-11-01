module Emulator
  module Cpu
    module Instruction
      class Opfe < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xFE), cycles: 8, label: 'CP d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          value = mmu[state.pc.read_value]
          state.pc.increment

          result = (state.a.read_value - value) & 0xFF

          state.f.toggle_zero_flag(result == 0x00)
          state.f.toggle_subtract_flag(true)
          state.f.toggle_half_carry_flag((result & 0xF) > (state.a.read_value & 0xF))
          state.f.toggle_carry_flag(state.a.read_value < value)

          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
