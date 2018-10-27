module Emulator
  module Cpu
    module Instruction
      class Op2c < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x2c), cycles: 4, label: 'INC L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          increment_byte_register(register: :l, state: state)
        end
      end
    end
  end
end
