module Emulator
  module Cpu
    module Instruction
      module Opcc
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'CALL Z,a16', opcode: 0xCC

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 24)
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {state.f.zero_flag_enabled?}
          state.f.zero_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
