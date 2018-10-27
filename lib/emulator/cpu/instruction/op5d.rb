module Emulator
  module Cpu
    module Instruction
      class Op5d < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x5D), cycles: 4, label: 'LD E,L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.e.write_value state.l.read_value
        end
      end
    end
  end
end
