module Emulator
  module Cpu
    module Instruction
      module Op14
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'INC D', opcode: 0x14

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          increment_byte_register(register: :d, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
