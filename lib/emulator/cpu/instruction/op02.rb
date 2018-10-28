module Emulator
  module Cpu
    module Instruction
      class Op02 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x02), cycles: 8, label: 'LD (BC),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_word_register_address_from_byte_register(address_register: :bc, register: :a, state: state, mmu: mmu)
        end
      end
    end
  end
end
