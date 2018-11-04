module Emulator
  module Cpu
    module Instruction
      module Op09
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'ADD HL,BC', opcode: 0x09

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          add_word_registers(primary_register: :hl, secondary_register: :bc, state: state)
          RESULT
        end
      end
    end
  end
end
