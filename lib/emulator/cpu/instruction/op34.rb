module Emulator
  module Cpu
    module Instruction
      class Op34 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x34), cycles: 12, label: 'INC (HL)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          addr = state.hl.read_value
          value = mmu[addr]
          mmu[addr] = value + 1
          updated_value = mmu[addr]

          ::Emulator::Cpu::Instruction::Helper::Flags::Increment.update_register_flags(state: state, value: value, updated_value: updated_value)
        end
      end
    end
  end
end
