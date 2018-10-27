module Emulator
  module Cpu
    module Instruction
      class Op75 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x75), cycles: 8, label: 'LD (HL),L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          mmu[state.hl.read_value] = state.l.read_value
        end
      end
    end
  end
end