module Emulator
  module Cpu
    module Instruction
      class Op42 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x42), cycles: 4, label: 'LD B,D')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.b.write_value state.d.read_value
        end
      end
    end
  end
end
