module Emulator
  module Cpu
    module Instruction
      class Opc8 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xC8), cycles: 20, label: 'RET Z')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {state.f.zero_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: state.f.zero_flag_enabled? ? 20 : 8)
        end
      end
    end
  end
end
