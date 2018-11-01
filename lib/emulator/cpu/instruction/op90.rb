module Emulator
  module Cpu
    module Instruction
      class Op90 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x90), cycles: 4, label: 'SUB B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          operand_value = state.b.read_value

          subtracted_value = (state.a.read_value - operand_value) & 0xFF

          ::Emulator::Cpu::Instruction::Helper::Flags::Subtraction.update_register_flags(state: state, operand_value: operand_value, subtracted_value: subtracted_value)

          state.a.write_value(subtracted_value)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
