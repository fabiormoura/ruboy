module Emulator
  module Cpu
    module Instruction
      module Op36
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Load

        mnemonic_definition 'LD (HL),d8', opcode: 0x36

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          load_target_address_from_pc_position_address(target_address: state.hl.read_value, state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
