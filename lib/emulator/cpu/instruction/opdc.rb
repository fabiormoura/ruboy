module Emulator
  module Cpu
    module Instruction
      class Opdc < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xdc), cycles: 24, label: 'CALL C,a16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {state.f.carry_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: state.f.carry_flag_enabled? ? 24 : 12)
        end
      end
    end
  end
end
