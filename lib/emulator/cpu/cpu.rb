module Emulator
  module Cpu
    class Cpu
      INSTRUCTIONS = [
          ::Emulator::Cpu::Instruction::Nop.new,
          ::Emulator::Cpu::Instruction::LdBcD16.new,
      ].freeze

      # @param [Emulator::Mmu] mmu
      # @param [Emulator::Cpu::RuntimeContext] context
      def initialize(mmu:, context:)
        @context = context
        @mmu = mmu
        @instructions = INSTRUCTIONS.map {|instruction| [instruction.instruction_id, instruction]}.to_h
      end

      def tick
        opcode = @mmu[@context.pc.read_value]
        instruction = @instructions[::Emulator::Cpu::Instruction::InstructionId.new(opcode)]
        @context.pc.increment
        raise NotImplementedError if instruction.nil?
        instruction.execute(mmu: @mmu, context: @context)
      end
    end
  end
end