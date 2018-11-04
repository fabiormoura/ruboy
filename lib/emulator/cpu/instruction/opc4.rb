module Emulator
  module Cpu
    module Instruction
      module Opc4
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'CALL NZ,a16', opcode: 0xC4

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 24).freeze
        NOP_RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {!state.f.zero_flag_enabled?}
          !state.f.zero_flag_enabled? ? RESULT : NOP_RESULT
        end
      end
    end
  end
end
