module Emulator
  module Cpu
    class Cpu
      INSTRUCTIONS = [
          ::Emulator::Cpu::Instruction::Op00.new,
          ::Emulator::Cpu::Instruction::Op01.new,
          ::Emulator::Cpu::Instruction::Op02.new,
          ::Emulator::Cpu::Instruction::Op03.new,
          ::Emulator::Cpu::Instruction::Op04.new
      ].freeze

      # @param [Emulator::Mmu] mmu
      # @param [Emulator::Cpu::State] state
      def initialize(mmu:, state:)
        @state = state
        @mmu = mmu
        @instructions = INSTRUCTIONS.map {|instruction| [instruction.instruction_id, instruction]}.to_h
      end

      def tick
        opcode = @mmu[@state.pc.read_value]
        instruction = @instructions[::Emulator::Cpu::Instruction::InstructionId.new(opcode)]
        @state.pc.increment
        raise NotImplementedError if instruction.nil?
        instruction.execute(mmu: @mmu, state: @state)
      end
    end
  end
end