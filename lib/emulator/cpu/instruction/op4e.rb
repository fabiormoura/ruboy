module Emulator
  module Cpu
    module Instruction
      class Op4e < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x4E), cycles: 8, label: 'LD C,(HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.c.write_value mmu[state.hl.read_value]
        end
      end
    end
  end
end
