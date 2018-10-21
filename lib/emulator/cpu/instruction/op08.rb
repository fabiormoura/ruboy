module Emulator
  module Cpu
    module Instruction
      class Op08 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x08), cycles: 20, label: 'LD (a16),SP')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          low_addr = mmu[state.pc.read_value]
          state.pc.increment
          high_addr = mmu[state.pc.read_value]
          state.pc.increment

          addr = high_addr << 8 | low_addr

          low_value = state.sp.read_value & 0xFF
          high_value = state.sp.read_value >> 8
          mmu[addr] = low_value
          mmu[addr + 1] = high_value
        end
      end
    end
  end
end
