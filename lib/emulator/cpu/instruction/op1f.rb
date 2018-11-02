module Emulator
  module Cpu
    module Instruction
      module Op1f
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        mnemonic_definition 'RRA', opcode: 0x1F

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          rotate_right_byte_register_using_carry_flag(register: :a, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
