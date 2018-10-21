module Emulator
  module Cpu
    module Instruction
      class Op02 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x02), cycles: 8, label: 'LD (BC),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          low_value = state.c.read_value
          high_value = state.b.read_value
          value = ((high_value << 8) | low_value);

          mmu[value] = state.a.read_value
        end
      end
    end
  end
end
