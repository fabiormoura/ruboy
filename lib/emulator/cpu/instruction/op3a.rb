module Emulator
  module Cpu
    module Instruction
      module Op3a
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD A,(HL-)', opcode: 0x3A

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_byte_register_from_address(address: state.hl.read_value, register: :a, state: state, mmu: mmu)
          state.hl.write_value(state.hl.read_value - 0x01)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
