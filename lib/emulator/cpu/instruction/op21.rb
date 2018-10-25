module Emulator
  module Cpu
    module Instruction
      class Op21 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x21), cycles: 12, label: 'LD HL,d16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_word_register_from_pc_position_address(register: :hl, state: state, mmu: mmu)
        end
      end
    end
  end
end