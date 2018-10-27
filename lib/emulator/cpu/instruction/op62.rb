module Emulator
  module Cpu
    module Instruction
      class Op62 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x62), cycles: 4, label: 'LD H,D')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.h.write_value state.d.read_value
        end
      end
    end
  end
end
