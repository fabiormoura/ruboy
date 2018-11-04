module Emulator
  module Cpu
    module Instruction
      module Ope0
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LDH (a8),A', opcode: 0xE0

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          address = 0xFF00 + mmu[state.pc.read_value]
          load_address_from_byte_register(address: address, register: :a, state: state, mmu: mmu)
          state.pc.increment
          RESULT
        end
      end
    end
  end
end
