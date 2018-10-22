module Emulator
  module Cpu
    module Instruction
      class Op18 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x18), cycles: 12, label: 'JR r8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          current_addr = state.pc.read_value
          offset = mmu[current_addr]
          state.pc.write_value(current_addr + 1 + signed_byte_value(offset))
        end
      end
    end
  end
end
