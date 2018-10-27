module Emulator
  module Cpu
    module Instruction
      class Op70 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x70), cycles: 8, label: 'LD (HL),B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          mmu[state.hl.read_value] = state.b.read_value
        end
      end
    end
  end
end
