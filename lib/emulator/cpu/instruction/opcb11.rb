module Emulator
  module Cpu
    module Instruction
      module Opcb11
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        mnemonic_definition 'RL C', opcode: 0xCB11

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          rotate_left_byte_register_using_carry_flag(register: :c, state: state, reset_zero_flag: false)
          RESULT
        end
      end
    end
  end
end
