module Emulator
  module Cpu
    module Instruction
      class Op03 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x03), cycles: 8, label: 'INC BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          increment_word_register(register: :bc, state: state)
        end
      end
    end
  end
end
