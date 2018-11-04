module Emulator
  module Cpu
    module Instruction
      module Opaa
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'XOR D', opcode: 0xAA

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          xor_byte_register(register: :a, value: state.d.read_value, state: state)
          RESULT
        end
      end
    end
  end
end
