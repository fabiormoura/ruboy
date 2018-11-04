module Emulator
  module Cpu
    module Event
      class CpuTicked
        attr_reader :opcode, :cycles, :state
        # @param [Integer] opcode
        # @param [Integer] cycles
        # @param [Emulator::Cpu::State] state
        def initialize(opcode:, cycles:, state:)
          @opcode = opcode
          @cycles = cycles
          @state = state
          freeze
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Cpu::Event::CpuTicked) && other.class == self.class
          @opcode == other.opcode &&
              @cycles == other.cycles &&
              @state == other.state
        end
      end
    end
  end
end