module Emulator
  module Cpu
    module Instruction
      class Opf0 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0xF0), cycles: 12, label: 'LDH A,(a8)')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          address_offset = mmu[state.pc.read_value]
          state.pc.increment
          state.a.write_value mmu[0xFF00 + address_offset]
        end
      end
    end
  end
end
