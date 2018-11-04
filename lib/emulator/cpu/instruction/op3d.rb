module Emulator
  module Cpu
    module Instruction
      module Op3d
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'DEC A', opcode: 0x3D

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 4)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          decrement_byte_register(register: :a, state: state)
          RESULT
        end
      end
    end
  end
end
