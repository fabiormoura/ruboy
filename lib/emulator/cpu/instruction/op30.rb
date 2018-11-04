module Emulator
  module Cpu
    module Instruction
      module Op30
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR NC,r8', opcode: 0x30

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
          !state.f.carry_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
