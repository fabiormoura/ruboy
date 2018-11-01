module Emulator
  module Cpu
    module Instruction
      class Op07 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x07), cycles: 4, label: 'RLCA')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          rotate_left_byte_register(register: :a, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
