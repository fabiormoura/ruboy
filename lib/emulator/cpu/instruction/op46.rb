module Emulator
  module Cpu
    module Instruction
      class Op46 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x46), cycles: 8, label: 'LD B,(HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.b.write_value mmu[state.hl.read_value]
        end
      end
    end
  end
end
