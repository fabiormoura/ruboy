module Emulator
  module Cpu
    module Instruction
      module Opd0
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET NC', opcode: 0xD0

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {!state.f.carry_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: !state.f.carry_flag_enabled? ? 20 : 8)
        end
      end
    end
  end
end
