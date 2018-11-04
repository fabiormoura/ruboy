module Emulator
  module Cpu
    module Instruction
      module Op2a
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD A,(HL+)', opcode: 0x2A

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_byte_register_from_address(address: state.hl.read_value, register: :a, state: state, mmu: mmu)
          state.hl.write_value(state.hl.read_value + 0x01)
          RESULT
        end
      end
    end
  end
end
