module Emulator
  module Cpu
    module Instruction
      class Op1d < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x1D), cycles: 4, label: 'DEC E')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          decrement_byte_register(register: :e, state: state)
        end
      end
    end
  end
end
