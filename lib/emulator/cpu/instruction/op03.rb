module Emulator
  module Cpu
    module Instruction
      class Op03 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x03), cycles: 8, label: 'INC BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          low_value = state.c.read_value
          high_value = state.b.read_value
          value = ((high_value << 8) | low_value) + 1

          state.c.write_value(value & 0x00FF)
          state.b.write_value(value >> 8)
        end
      end
    end
  end
end
