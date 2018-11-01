module Emulator
  module Cpu
    module Instruction
      class Result
        attr_reader :cycles

        # @param [Integer] cycles
        def initialize(cycles:)
          @cycles = cycles
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Cpu::Instruction::Result) && other.class == self.class
          @cycles == other.cycles
        end
      end
    end
  end
end