module Emulator
  module Cpu
    module Instruction
      module Op39
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'ADD HL,SP', opcode: 0x39

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          add_word_registers(primary_register: :hl, secondary_register: :sp, state: state)
          RESULT
        end
      end
    end
  end
end
