module Emulator
  module Cpu
    module Instruction
      class Op49 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x49), cycles: 4, label: 'LD C,C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.c.write_value state.c.read_value
        end
      end
    end
  end
end
