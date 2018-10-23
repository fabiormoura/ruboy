module Emulator
  module Cpu
    module Instruction
      class Op17 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x17), cycles: 4, label: 'RLA')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          rotate_left_byte_register_using_carry_flag(register: :a, state: state)
        end
      end
    end
  end
end
