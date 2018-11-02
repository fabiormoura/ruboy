module Emulator
  module Cpu
    module Instruction
      module Op11
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD DE,d16', opcode: 0x11

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_word_register_from_pc_position_address(register: :de, state: state, mmu: mmu)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 12)
        end
      end
    end
  end
end
