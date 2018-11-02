module Emulator
  module Cpu
    module Instruction
      module Opc8
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET Z', opcode: 0xC8

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu) {state.f.zero_flag_enabled?}
          ::Emulator::Cpu::Instruction::Result.new(cycles: state.f.zero_flag_enabled? ? 20 : 8)
        end
      end
    end
  end
end
