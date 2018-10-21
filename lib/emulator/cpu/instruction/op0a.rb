module Emulator
  module Cpu
    module Instruction
      class Op0a < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x0A), cycles: 8, label: 'LD A,(BC)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value mmu[state.bc.read_value]
        end
      end
    end
  end
end
