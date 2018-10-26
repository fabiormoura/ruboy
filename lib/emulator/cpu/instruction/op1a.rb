module Emulator
  module Cpu
    module Instruction
      class Op1a < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x1A), cycles: 8, label: 'LD A,(DE)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value mmu[state.de.read_value]
        end
      end
    end
  end
end
