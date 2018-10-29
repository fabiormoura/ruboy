module Emulator
  module Cpu
    module Instruction
      class Opc0 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xc0), cycles: 20, label: 'RET NZ')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {!state.f.zero_flag_enabled?}
        end
      end
    end
  end
end
