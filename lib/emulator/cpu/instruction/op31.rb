module Emulator
  module Cpu
    module Instruction
      module Op31
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD SP,d16', opcode: 0x31

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_word_register_from_pc_position_address(register: :sp, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
