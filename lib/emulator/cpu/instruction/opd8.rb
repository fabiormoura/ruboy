module Emulator
  module Cpu
    module Instruction
      module Opd8
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET C', opcode: 0xD8

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 20)
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {state.f.carry_flag_enabled?}
          state.f.carry_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
