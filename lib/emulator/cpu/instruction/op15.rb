module Emulator
  module Cpu
    module Instruction
      module Op15
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'DEC D', opcode: 0x15

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          decrement_byte_register(register: :d, state: state)
          RESULT
        end
      end
    end
  end
end
