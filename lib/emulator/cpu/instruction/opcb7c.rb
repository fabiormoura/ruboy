module Emulator
  module Cpu
    module Instruction
      class Opcb7c < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Bit

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xCB7C), cycles: 8, label: 'BIT 7,H')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          bit_test_byte_register(bit: 7, register: :h, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
