module Emulator
  module Cpu
    module Instruction
      class Op07 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x07), cycles: 4, label: 'RLCA')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          value = state.a.read_value
          bit = (value >> 7) & 1

          state.a.write_value(value << 1 & 0xFF | bit)
          state.f.toggle_zero_flag(false)
          state.f.toggle_subtract_flag(false)
          state.f.toggle_half_carry_flag(false)
          state.f.toggle_carry_flag(bit != 0)
        end
      end
    end
  end
end
