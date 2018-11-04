module Emulator
  module Cpu
    module Instruction
      module Op03
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'INC BC', opcode: 0x03

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          increment_word_register(register: :bc, state: state)
          RESULT
        end
      end
    end
  end
end
