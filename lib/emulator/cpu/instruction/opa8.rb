module Emulator
  module Cpu
    module Instruction
      class Opa8 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xA8), cycles: 4, label: 'XOR B')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          xor_byte_register(register: :a, value: state.b.read_value, state: state)
        end
      end
    end
  end
end
