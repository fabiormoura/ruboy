module Emulator
  module Cpu
    module Instruction
      class Op56 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x56), cycles: 8, label: 'LD D,(HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.d.write_value mmu[state.hl.read_value]
        end
      end
    end
  end
end
