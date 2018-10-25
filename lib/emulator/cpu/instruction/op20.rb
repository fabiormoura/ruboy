module Emulator
  module Cpu
    module Instruction
      class Op20 < ::Emulator::Cpu::Instruction::Instruction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x20), cycles: 12, label: 'JR NZ,r8')
        end

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def execute(state:, mmu:)
          current_addr = state.pc.read_value
          addr = current_addr + 1
          addr += signed_byte_value(mmu[current_addr]) unless state.f.zero_flag_enabled?
          state.pc.write_value(addr)
        end
      end
    end
  end
end
