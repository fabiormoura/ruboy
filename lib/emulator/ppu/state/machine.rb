module Emulator
  module Ppu
    module State
      class Machine
        attr_reader :active_mode

        # @param [::Emulator::Ppu::Ppu] ppu
        def initialize(ppu:)
          @ppu = ppu
          @active_mode = ::Emulator::Ppu::State::Modes::OAM_SEARCH
          super()
        end

        def oam_search_completed
          @active_mode = ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
        end

        def pixel_transfer_completed
          @active_mode = ::Emulator::Ppu::State::Modes::H_BLANK
        end

        def h_blank_completed
          @active_mode = @ppu.lcd_y.v_blank_period? ? ::Emulator::Ppu::State::Modes::V_BLANK : ::Emulator::Ppu::State::Modes::OAM_SEARCH
        end

        def v_blank_completed
          @active_mode = ::Emulator::Ppu::State::Modes::OAM_SEARCH unless @ppu.lcd_y.v_blank_period?
        end
      end
    end
  end
end