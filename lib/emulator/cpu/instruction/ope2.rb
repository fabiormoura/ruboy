module Emulator
  module Cpu
    module Instruction
      class Ope2 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xE2), cycles: 8, label: 'LD (C),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          address = 0xFF00 + state.c.read_value
          load_address_from_byte_register(address: address, register: :a, state: state, mmu: mmu)
          state.pc.increment
          ::Emulator::Cpu::Instruction::Result.new(cycles: 8)
        end
      end
    end
  end
end
