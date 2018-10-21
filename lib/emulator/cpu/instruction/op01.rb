module Emulator
  module Cpu
    module Instruction
      class Op01 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Move

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x01), cycles: 12, label: 'LD BC,d16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          move_word_register_from_d16(register: :bc, state: state, mmu: mmu)
        end
      end
    end
  end
end
