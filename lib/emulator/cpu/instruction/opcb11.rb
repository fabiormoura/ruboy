module Emulator
  module Cpu
    module Instruction
      class Opcb11 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xCB11), cycles: 8, label: 'RL C')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          rotate_left_byte_register_using_carry_flag(register: :c, state: state, reset_zero_flag: false)
        end
      end
    end
  end
end
