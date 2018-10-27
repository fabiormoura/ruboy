module Emulator
  module Cpu
    module Instruction
      class Op36 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x36), cycles: 12, label: 'LD (HL),d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_target_address_from_pc_position_address(target_address: state.hl.read_value, state: state, mmu: mmu)
        end
      end
    end
  end
end
