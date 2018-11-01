module Emulator
  module Cpu
    module Instruction
      class Op20 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x20), cycles: 12, label: 'JR NZ,r8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu) {!state.f.zero_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: !state.f.zero_flag_enabled? ? 12 : 8)
        end
      end
    end
  end
end
