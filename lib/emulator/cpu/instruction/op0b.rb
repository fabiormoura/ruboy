module Emulator
  module Cpu
    module Instruction
      class Op0b < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x0B), cycles: 8, label: 'DEC BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.bc.write_value(state.bc.read_value - 1)
        end
      end
    end
  end
end
