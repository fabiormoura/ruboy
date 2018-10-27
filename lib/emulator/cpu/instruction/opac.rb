module Emulator
  module Cpu
    module Instruction
      class Opac < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xAC), cycles: 4, label: 'XOR H')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.h.read_value)
        end
      end
    end
  end
end
