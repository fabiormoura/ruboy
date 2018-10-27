module Emulator
  module Cpu
    module Instruction
      class Opaa < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xAA), cycles: 4, label: 'XOR D')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.d.read_value)
        end
      end
    end
  end
end
