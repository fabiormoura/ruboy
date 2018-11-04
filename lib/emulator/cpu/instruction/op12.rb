module Emulator
  module Cpu
    module Instruction
      module Op12
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD (DE),A', opcode: 0x12

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_word_register_address_from_byte_register(address_register: :de, register: :a, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
