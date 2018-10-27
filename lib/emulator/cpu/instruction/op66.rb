module Emulator
  module Cpu
    module Instruction
      class Op66 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x66), cycles: 8, label: 'LD H,(HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.h.write_value mmu[state.hl.read_value]
        end
      end
    end
  end
end
