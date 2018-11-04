module Emulator
  module Cpu
    module Instruction
      module Op2d
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'DEC L', opcode: 0x2D

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          decrement_byte_register(register: :l, state: state)
          RESULT
        end
      end
    end
  end
end
