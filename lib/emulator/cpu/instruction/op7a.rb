module Emulator
  module Cpu
    module Instruction
      class Op7a < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x7A), cycles: 4, label: 'LD A,D')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value state.d.read_value
        end
      end
    end
  end
end