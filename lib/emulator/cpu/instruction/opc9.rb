module Emulator
  module Cpu
    module Instruction
      class Opc9 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xC9), cycles: 16, label: 'RET')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          return_address(state: state, mmu: mmu)
        end
      end
    end
  end
end
