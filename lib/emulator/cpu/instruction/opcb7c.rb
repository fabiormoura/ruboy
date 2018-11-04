module Emulator
  module Cpu
    module Instruction
      module Opcb7c
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Bit

        mnemonic_definition 'BIT 7,H', opcode: 0xCB7C

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          bit_test_byte_register(bit: 7, register: :h, state: state)
          RESULT
        end
      end
    end
  end
end
