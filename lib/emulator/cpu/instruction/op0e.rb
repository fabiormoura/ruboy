module Emulator
  module Cpu
    module Instruction
      class Op0e < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Move

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x0E), cycles: 8, label: 'LD C,d8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          move_byte_register_from_d8(register: :c, state: state, mmu: mmu)
        end
      end
    end
  end
end
