module Emulator
  module Cpu
    module Instruction
      module Opb1
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'OR C', opcode: 0xB1

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          or_byte_register(register: :a, value: state.c.read_value, state: state)
          RESULT
        end
      end
    end
  end
end
