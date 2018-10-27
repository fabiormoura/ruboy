module Emulator
  module Cpu
    module Instruction
      class Op59 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x59), cycles: 4, label: 'LD E,C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.e.write_value state.c.read_value
        end
      end
    end
  end
end
