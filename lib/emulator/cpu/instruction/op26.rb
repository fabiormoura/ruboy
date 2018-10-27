module Emulator
  module Cpu
    module Instruction
      class Op26 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x26), cycles: 8, label: 'LD H,d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_byte_register_from_pc_position_address(register: :h, state: state, mmu: mmu)
        end
      end
    end
  end
end
