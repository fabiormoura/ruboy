module Emulator
  module Cpu
    module Instruction
      module Opea
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD (a16),A', opcode: 0xEA

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 16)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]
          state.pc.increment(offset: 2)
          load_address_from_byte_register(address: address, register: :a, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
