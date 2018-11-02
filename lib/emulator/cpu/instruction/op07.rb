module Emulator
  module Cpu
    module Instruction
      module Op07
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Rotate

        mnemonic_definition 'RLCA', opcode: 0x07

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          rotate_left_byte_register(register: :a, state: state)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
