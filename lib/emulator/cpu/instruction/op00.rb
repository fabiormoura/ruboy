module Emulator
  module Cpu
    module Instruction
      class Op00 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x00), cycles: 4, label: 'NOP')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
        end
      end
    end
  end
end
