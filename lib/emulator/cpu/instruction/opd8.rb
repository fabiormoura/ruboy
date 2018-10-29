module Emulator
  module Cpu
    module Instruction
      class Opd8 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xD8), cycles: 20, label: 'RET C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {state.f.carry_flag_enabled?}
        end
      end
    end
  end
end
