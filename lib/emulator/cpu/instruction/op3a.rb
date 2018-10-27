module Emulator
  module Cpu
    module Instruction
      class Op3a < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Load

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x3A), cycles: 8, label: 'LD A,(HL-)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          load_byte_register_from_address(address: state.hl.read_value, register: :a, state: state, mmu: mmu)
          state.hl.write_value(state.hl.read_value - 0x01)
        end
      end
    end
  end
end
