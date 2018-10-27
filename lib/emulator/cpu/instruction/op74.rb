module Emulator
  module Cpu
    module Instruction
      class Op74 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x74), cycles: 8, label: 'LD (HL),H')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          mmu[state.hl.read_value] = state.h.read_value
        end
      end
    end
  end
end