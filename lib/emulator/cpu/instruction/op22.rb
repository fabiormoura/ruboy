module Emulator
  module Cpu
    module Instruction
      module Op22
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD (HL+),A', opcode: 0x22

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_word_register_address_from_byte_register(address_register: :hl, register: :a, state: state, mmu: mmu)
          state.hl.write_value(state.hl.read_value + 0x01)
          RESULT
        end
      end
    end
  end
end
