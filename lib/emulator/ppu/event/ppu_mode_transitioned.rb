module Emulator
  module Ppu
    module Event
      class PpuModeTransitioned
        attr_reader :previous_mode, :active_mode

        # @param [::Emulator::Ppu::State::Mode] previous_mode
        # @param [::Emulator::Ppu::State::Mode] active_mode
        def initialize(previous_mode:, active_mode:)
          @previous_mode = previous_mode
          @active_mode = active_mode
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Ppu::Event::PpuModeTransitioned) && other.class == self.class
          @opcode == other.opcode &&
              @cycles == other.cycles &&
              @state == other.state
        end
      end
    end
  end
end