module Emulator
  module Cpu
    module Instruction
      module Op17
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        mnemonic_definition 'RLA', opcode: 0x17

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          rotate_left_byte_register_using_carry_flag(register: :a, state: state)
          RESULT
        end
      end
    end
  end
end
