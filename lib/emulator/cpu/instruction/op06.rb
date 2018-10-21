module Emulator
  module Cpu
    module Instruction
      class Op06 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x06), cycles: 8, label: 'LD B,d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          value = mmu[state.pc.read_value]
          state.pc.increment

          state.b.write_value(value)
        end
      end
    end
  end
end
