module Emulator
  module Cpu
    module Instruction
      class Op0c < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x0c), cycles: 4, label: 'INC C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          increment_byte_register(register: :c, state: state)
        end
      end
    end
  end
end