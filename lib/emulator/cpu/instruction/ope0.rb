module Emulator
  module Cpu
    module Instruction
      class Ope0 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xE0), cycles: 12, label: 'LDH (a8),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          address = 0xFF00 + mmu[state.pc.read_value]
          load_address_from_byte_register(address: address, register: :a, state: state, mmu: mmu)
          state.pc.increment
        end
      end
    end
  end
end
