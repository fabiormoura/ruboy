module Emulator
  module Cpu
    module Instruction
      class Opad < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xAD), cycles: 4, label: 'XOR L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(state.a.read_value ^ state.l.read_value)
        end
      end
    end
  end
end
