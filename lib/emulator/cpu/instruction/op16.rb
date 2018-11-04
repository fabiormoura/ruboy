module Emulator
  module Cpu
    module Instruction
      module Op16
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD D,d8', opcode: 0x16

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_byte_register_from_pc_position_address(register: :d, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
