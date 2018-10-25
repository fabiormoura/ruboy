module Emulator
  module Cpu
    module Instruction
      class Op4c < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x4C), cycles: 4, label: 'LD C,H')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.c.write_value state.h.read_value
        end
      end
    end
  end
end
