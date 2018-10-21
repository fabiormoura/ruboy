module Emulator
  module Cpu
    module Instruction
      class Op03 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x03), cycles: 8, label: 'INC BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          value = state.bc.read_value + 1
          state.bc.write_value(value)
        end
      end
    end
  end
end
