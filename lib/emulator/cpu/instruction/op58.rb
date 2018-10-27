module Emulator
  module Cpu
    module Instruction
      class Op58 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x58), cycles: 4, label: 'LD E,B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.e.write_value state.b.read_value
        end
      end
    end
  end
end
