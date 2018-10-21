module Emulator
  module Cpu
    module Instruction
      class InstructionId
        attr_reader :opcode
        @@default_comparator = -> (opcode, other_opcode) {opcode == other_opcode}

        # @param [Integer] opcode
        # @param [Proc] comparator
        def initialize(opcode = nil, &comparator)
          @opcode = opcode
          @comparator = comparator
        end

        # @param [InstructionId] other
        def eql?(other)
          return false unless other.is_a?(::Emulator::Cpu::Instruction::InstructionId) && other.class == self.class
          other.matches_opcode?(@opcode) || matches_opcode?(other.opcode)
        end

        # @param [Integer] opcode
        # @return [TrueClass|FalseClass]
        def matches_opcode?(opcode)
          return @comparator.call(opcode) unless @comparator.nil?
          @@default_comparator.call(@opcode, opcode)
        end

        def hash
          1.hash
        end
      end
    end
  end
end