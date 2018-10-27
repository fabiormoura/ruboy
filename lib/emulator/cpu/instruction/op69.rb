module Emulator
  module Cpu
    module Instruction
      class Op69 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x69), cycles: 4, label: 'LD L,C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.l.write_value state.c.read_value
        end
      end
    end
  end
end
