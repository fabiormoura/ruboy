module Emulator
  module Cpu
    module Instruction
      module Op02
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD (BC),A', opcode: 0x02

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_word_register_address_from_byte_register(address_register: :bc, register: :a, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
