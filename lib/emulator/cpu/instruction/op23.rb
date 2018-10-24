module Emulator
  module Cpu
    module Instruction
      class Op23 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x23), cycles: 8, label: 'INC HL')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          increment_word_register(register: :hl, state: state)
        end
      end
    end
  end
end
