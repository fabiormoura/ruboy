module Emulator
  module Cpu
    module Instruction
      class Opd4 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xd4), cycles: 24, label: 'CALL NC,a16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
        end
      end
    end
  end
end
