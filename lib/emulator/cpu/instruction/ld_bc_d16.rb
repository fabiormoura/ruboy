module Emulator
  module Cpu
    module Instruction
      class LdBcD16 < ::Emulator::Cpu::Instruction::Instruction
        def initialize
          super(instruction_id: ::Emulator::Cpu::Instruction::InstructionId.new(0x01), cycles: 12, label: 'LD BC,d16')
        end

        # @param [::Emulator::Cpu::RuntimeContext] context
        # @param [::Emulator::Mmu] mmu
        def execute(context:, mmu:)
          low_value = mmu[context.pc.read_value]
          context.pc.increment
          high_value = mmu[context.pc.read_value]
          context.pc.increment

          context.c.write_value(low_value)
          context.b.write_value(high_value)
        end
      end
    end
  end
end
