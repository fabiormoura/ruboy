module Emulator
  module Cpu
    module Instruction
      class Op65 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x65), cycles: 4, label: 'LD H,L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.h.write_value state.l.read_value
        end
      end
    end
  end
end
