module Emulator
  module Cpu
    module Instruction
      module Opdc
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'CALL C,a16', opcode: 0xDC

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          call_address(state: state, mmu: mmu) {state.f.carry_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: state.f.carry_flag_enabled? ? 24 : 12)
        end
      end
    end
  end
end
