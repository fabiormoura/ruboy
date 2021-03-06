module Emulator
  module Cpu
    module Instruction
      module Op0f
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        mnemonic_definition 'RRCA', opcode: 0x0F

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          rotate_right_byte_register(register: :a, state: state)
          RESULT
        end
      end
    end
  end
end
