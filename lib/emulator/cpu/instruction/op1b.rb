module Emulator
  module Cpu
    module Instruction
      class Op1b < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x1B), cycles: 8, label: 'DEC DE')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.de.write_value(state.de.read_value - 1)
        end
      end
    end
  end
end
