module Emulator
  module Cpu
    module Instruction
      module Opd4
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'CALL NC,a16', opcode: 0xD4

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 24).freeze
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
          !state.f.carry_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
