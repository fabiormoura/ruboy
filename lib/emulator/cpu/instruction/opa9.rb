module Emulator
  module Cpu
    module Instruction
      class Opa9 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xA9), cycles: 4, label: 'XOR C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.c.read_value)
        end
      end
    end
  end
end
