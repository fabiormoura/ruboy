module Emulator
  module Cpu
    module Instruction
      class Op22 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x22), cycles: 8, label: 'LD (HL+),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_word_register_address_from_a_register(register: :hl, state: state, mmu: mmu)
          state.hl.write_value(state.hl.read_value + 0x01)
        end
      end
    end
  end
end
