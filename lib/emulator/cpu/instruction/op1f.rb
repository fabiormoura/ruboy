module Emulator
  module Cpu
    module Instruction
      class Op1f < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x1F), cycles: 4, label: 'RRA')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          rotate_right_byte_register_using_carry_flag(register: :a, state: state)
        end
      end
    end
  end
end
