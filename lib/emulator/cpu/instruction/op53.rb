module Emulator
  module Cpu
    module Instruction
      class Op53 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x53), cycles: 4, label: 'LD D,E')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.d.write_value state.e.read_value
        end
      end
    end
  end
end