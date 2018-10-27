module Emulator
  module Cpu
    module Instruction
      class Opab < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xAB), cycles: 4, label: 'XOR E')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.e.read_value)
        end
      end
    end
  end
end
