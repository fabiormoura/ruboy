module Emulator
  module Cpu
    module Instruction
      class Opcd < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xcd), cycles: 24, label: 'CALL a16')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          jump_address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]

          state.pc.increment(offset: 2)

          state.sp.write_value(state.sp.read_value - 1)
          mmu[state.sp.read_value] = (state.pc.read_value >> 8) & 0xFF

          state.sp.write_value(state.sp.read_value - 1)
          mmu[state.sp.read_value] = (state.pc.read_value & 0xFF)

          state.pc.write_value(jump_address)
        end
      end
    end
  end
end
