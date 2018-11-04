module Emulator
  module Cpu
    module Instruction
      module Opd0
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET NC', opcode: 0xD0

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 20).freeze
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
          !state.f.carry_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
