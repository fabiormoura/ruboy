module Emulator
  module Cpu
    module Instruction
      module Op23
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'INC HL', opcode: 0x23

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          increment_word_register(register: :hl, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
