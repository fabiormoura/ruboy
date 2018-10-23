module Emulator
  module Cpu
    module Instruction
      class Op2d < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x2D), cycles: 4, label: 'DEC L')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          decrement_byte_register(register: :l, state: state)
        end
      end
    end
  end
end
