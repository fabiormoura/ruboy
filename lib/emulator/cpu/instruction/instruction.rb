module Emulator
  module Cpu
    module Instruction
      class Instruction
        attr_reader :instruction_id
        attr_reader :cycles
        # @param [::Emulator::Cpu::Instruction::InstructionId] instruction_id
        # @param [Integer] cycles
        # @param [String] label
        def initialize(instruction_id:, cycles:, label:)
          @instruction_id = instruction_id
          @cycles = cycles
          @label
        end

        # @param [::Emulator::Cpu::RuntimeContext] context
        # @param [::Emulator::Mmu] mmu
        def execute(context:, mmu:)
          raise NotImplementedError
        end

        def skip_opcode?(opcode)
          !@instruction_id.matches_opcode?(opcode)
        end

        def to_s
          @label
        end
      end
    end
  end
end
