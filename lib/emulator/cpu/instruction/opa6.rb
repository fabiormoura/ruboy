module Emulator
  module Cpu
    module Instruction
      module Opa6
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'AND (HL)', opcode: 0xA6

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          and_byte_register(register: :a, value: mmu[state.hl.read_value], state: state)
          RESULT
        end
      end
    end
  end
end
