module Emulator
  module Cpu
    module Instruction
      class Op2f < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x2F), cycles: 4, label: 'CPL')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          state.a.write_value(~state.a.read_value & 0xFF)
        end
      end
    end
  end
end
