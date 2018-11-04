module Emulator
  module Cpu
    module Instruction
      module Op87
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'ADD A,A', opcode: 0x87

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          add_value_to_byte_register(register: :a, operand_value: state.a.read_value, state: state)
          RESULT
        end
      end
    end
  end
end
