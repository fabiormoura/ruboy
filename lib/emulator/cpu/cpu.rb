module Emulator
  module Cpu
    class Cpu
      INSTRUCTIONS = [
          ::Emulator::Cpu::Instruction::Op00.new,
          ::Emulator::Cpu::Instruction::Op01.new,
          ::Emulator::Cpu::Instruction::Op02.new,
          ::Emulator::Cpu::Instruction::Op03.new,
          ::Emulator::Cpu::Instruction::Op04.new,
          ::Emulator::Cpu::Instruction::Op05.new,
          ::Emulator::Cpu::Instruction::Op06.new,
          ::Emulator::Cpu::Instruction::Op07.new,
          ::Emulator::Cpu::Instruction::Op08.new,
          ::Emulator::Cpu::Instruction::Op09.new,
          ::Emulator::Cpu::Instruction::Op0a.new,
          ::Emulator::Cpu::Instruction::Op0b.new,
          ::Emulator::Cpu::Instruction::Op0c.new,
          ::Emulator::Cpu::Instruction::Op0d.new,
          ::Emulator::Cpu::Instruction::Op0e.new,
          ::Emulator::Cpu::Instruction::Op0f.new,
          # TODO: ::Emulator::Cpu::Instruction::Op10.new,
          ::Emulator::Cpu::Instruction::Op11.new,
          ::Emulator::Cpu::Instruction::Op12.new,
          ::Emulator::Cpu::Instruction::Op13.new,
          ::Emulator::Cpu::Instruction::Op14.new,
          ::Emulator::Cpu::Instruction::Op15.new,
          ::Emulator::Cpu::Instruction::Op16.new,
          ::Emulator::Cpu::Instruction::Op18.new
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