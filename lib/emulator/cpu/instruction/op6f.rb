module Emulator
  module Cpu
    module Instruction
      class Op6f < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x6F), cycles: 4, label: 'LD L,A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.l.write_value state.a.read_value
        end
      end
    end
  end
end
