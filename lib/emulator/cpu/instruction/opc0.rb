module Emulator
  module Cpu
    module Instruction
      module Opc0
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET NZ', opcode: 0xC0

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 20).freeze
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {!state.f.zero_flag_enabled?}
          !state.f.zero_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
