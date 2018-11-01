module Emulator
  module Cpu
    module Instruction
      class Op7f < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x7F), cycles: 4, label: 'LD A,A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value state.a.read_value
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
