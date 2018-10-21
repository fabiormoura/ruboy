module Emulator
  module Cpu
    module Instruction
      class Op01 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x01), cycles: 12, label: 'LD BC,d16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          low_value = mmu[state.pc.read_value]
          state.pc.increment
          high_value = mmu[state.pc.read_value]
          state.pc.increment

          state.bc.write_values(low_value: low_value, high_value: high_value)
        end
      end
    end
  end
end
