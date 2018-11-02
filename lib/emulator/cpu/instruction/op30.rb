module Emulator
  module Cpu
    module Instruction
      module Op30
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR NC,r8', opcode: 0x30

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: !state.f.carry_flag_enabled? ? 12 : 8)
        end
      end
    end
  end
end
