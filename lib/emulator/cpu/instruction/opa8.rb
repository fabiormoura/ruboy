module Emulator
  module Cpu
    module Instruction
      class Opa8 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xA8), cycles: 4, label: 'XOR B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.b.read_value)
        end
      end
    end
  end
end
