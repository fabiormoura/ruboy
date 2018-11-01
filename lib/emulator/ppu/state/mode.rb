module Emulator
  module Ppu
    module State
      class Mode
        attr_reader :name, :required_cycles

        # @param [String] name
        # @param [Integer] required_cycles
        def initialize(name:, required_cycles:)
          @name = name
          @required_cycles = required_cycles
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Ppu::State::Mode) && other.class == self.class
          @name == other.name &&
              @required_cycles == other.required_cycles
        end
      end
    end
  end
end