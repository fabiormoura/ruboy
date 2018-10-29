module Emulator
  module Cpu
    module Instruction
      class Opc5 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Stack

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xc5), cycles: 16, label: 'PUSH BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          push_word_value_onto_stack(value: state.bc.read_value, state: state, mmu: mmu)
        end
      end
    end
  end
end
