module Emulator
  module Cpu
    module Instruction
      class Opab < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xAB), cycles: 4, label: 'XOR E')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          xor_byte_register(register: :a, value: state.e.read_value, state: state)
        end
      end
    end
  end
end
