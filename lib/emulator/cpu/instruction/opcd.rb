module Emulator
  module Cpu
    module Instruction
      module Opcd
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'CALL a16', opcode: 0xCD

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 24)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          call_address(state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
