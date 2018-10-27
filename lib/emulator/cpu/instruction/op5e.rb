module Emulator
  module Cpu
    module Instruction
      class Op5e < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x5E), cycles: 8, label: 'LD E,(HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.e.write_value mmu[state.hl.read_value]
        end
      end
    end
  end
end
