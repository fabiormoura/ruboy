module Emulator
  module Cpu
    module Instruction
      class Op47 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x47), cycles: 4, label: 'LD B,A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.b.write_value state.a.read_value
        end
      end
    end
  end
end
