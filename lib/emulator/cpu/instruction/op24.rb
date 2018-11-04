module Emulator
  module Cpu
    module Instruction
      module Op24
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'INC H', opcode: 0x24

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          increment_byte_register(register: :h, state: state)
          RESULT
        end
      end
    end
  end
end
