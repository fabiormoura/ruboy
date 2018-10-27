module Emulator
  module Cpu
    module Instruction
      class Op64 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x64), cycles: 4, label: 'LD H,H')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.h.write_value state.h.read_value
        end
      end
    end
  end
end
