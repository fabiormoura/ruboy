module Emulator
  module Cpu
    module Instruction
      module Op28
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR Z,r8', opcode: 0x28

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu) {state.f.zero_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: state.f.zero_flag_enabled? ? 12 : 8)
        end
      end
    end
  end
end
