module Emulator
  module Cpu
    module Instruction
      class Opea < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xEA), cycles: 16, label: 'LD (a16),A')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]
          state.pc.increment(offset: 2)
          load_address_from_byte_register(address: address, register: :a, state: state, mmu: mmu)
        end
      end
    end
  end
end
