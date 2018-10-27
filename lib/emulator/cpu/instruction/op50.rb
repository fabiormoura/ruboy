module Emulator
  module Cpu
    module Instruction
      class Op50 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x50), cycles: 4, label: 'LD D,B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.d.write_value state.b.read_value
        end
      end
    end
  end
end
