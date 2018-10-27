module Emulator
  module Cpu
    module Instruction
      class Op5a < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x5A), cycles: 4, label: 'LD E,D')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.e.write_value state.d.read_value
        end
      end
    end
  end
end
