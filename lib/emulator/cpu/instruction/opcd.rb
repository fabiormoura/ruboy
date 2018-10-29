module Emulator
  module Cpu
    module Instruction
      class Opcd < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Jump

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xcd), cycles: 24, label: 'CALL a16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          call_address(state: state, mmu: mmu)
        end
      end
    end
  end
end
