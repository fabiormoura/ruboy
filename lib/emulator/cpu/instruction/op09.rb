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
          low_value = state.l.read_value
          high_value = state.h.read_value

          hl_value = ((high_value << 8) | low_value)

          low_value = state.c.read_value
          high_value = state.b.read_value

          bc_value = ((high_value << 8) | low_value)

          value = hl_value + bc_value
          u16_value = (hl_value + bc_value) & 0xFFFF
          state.l.write_value(u16_value & 0xFF)
          state.h.write_value(u16_value >> 8)

          state.f.toggle_subtract_flag(false)
          state.f.toggle_half_carry_flag((hl_value & 0xFFF) + (bc_value & 0xFFF) > 0xFFF)
          state.f.toggle_carry_flag(value >> 16 > 0)
        end
      end
    end
  end
end
