module Emulator
  module Cpu
    module Instruction
      class Nop < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x00), cycles: 4, label: 'NOP')
        end

        # @param [::Emulator::Cpu::RuntimeContext] context
        # @param [::Emulator::Mmu] mmu
        def execute(context:, mmu:)
        end
      end
    end
  end
end
