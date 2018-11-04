module Emulator
  module Cpu
    module Instruction
      module Op38
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR C,r8', opcode: 0x38

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu) {state.f.carry_flag_enabled?}
          state.f.carry_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
