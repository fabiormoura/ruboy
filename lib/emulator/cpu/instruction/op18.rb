module Emulator
  module Cpu
    module Instruction
      module Op18
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        mnemonic_definition 'JR r8', opcode: 0x18

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          jump_to_signed_byte_offset(state: state, mmu: mmu)
          RESULT
        end
      end
    end
  end
end
