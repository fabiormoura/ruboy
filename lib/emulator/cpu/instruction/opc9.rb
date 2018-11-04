module Emulator
  module Cpu
    module Instruction
      module Opc9
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'RET', opcode: 0xC9

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 16).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          return_address(state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
