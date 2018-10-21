module Emulator
  module Cpu
    module Instruction
      class Op09 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x09), cycles: 8, label: 'ADD HL,BC')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          hl_value = state.hl.read_value
          bc_value = state.bc.read_value

          value = hl_value + bc_value
          u16_value = (hl_value + bc_value) & 0xFFFF

          state.hl.write_value(u16_value)

          state.f.toggle_subtract_flag(false)
          state.f.toggle_half_carry_flag((hl_value & 0xFFF) + (bc_value & 0xFFF) > 0xFFF)
          state.f.toggle_carry_flag(value >> 16 > 0)
        end
      end
    end
  end
end
