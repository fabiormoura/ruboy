module Emulator
  module Ppu
    module State
      class Machine
        attr_reader :active_mode

        # @param [::Emulator::Ppu::Ppu] ppu
        # @param [::Emulator::BroadcastChannel] channel
        def initialize(ppu:, channel:)
          @ppu = ppu
          @channel = channel
          @active_mode = ::Emulator::Ppu::State::Modes::OAM_SEARCH
        end

        def oam_search_completed
          previous_mode = @active_mode
          @active_mode = ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
          @channel.announce(::Emulator::Ppu::Event::PpuModeTransitioned.new(previous_mode: previous_mode, active_mode: @active_mode))
        end

        def pixel_transfer_completed
          previous_mode = @active_mode
          @active_mode = ::Emulator::Ppu::State::Modes::H_BLANK
          @channel.announce(::Emulator::Ppu::Event::PpuModeTransitioned.new(previous_mode: previous_mode, active_mode: @active_mode))
        end

        def h_blank_completed
          previous_mode = @active_mode

          @active_mode = @ppu.lcd_y.v_blank_period? ? ::Emulator::Ppu::State::Modes::V_BLANK : ::Emulator::Ppu::State::Modes::OAM_SEARCH

          @channel.announce(::Emulator::Ppu::Event::PpuModeTransitioned.new(previous_mode: previous_mode, active_mode: @active_mode))
        end

        def v_blank_completed
          previous_mode = @active_mode

          @active_mode = ::Emulator::Ppu::State::Modes::OAM_SEARCH unless @ppu.lcd_y.v_blank_period?

          @channel.announce(::Emulator::Ppu::Event::PpuModeTransitioned.new(previous_mode: previous_mode, active_mode: @active_mode))
        end
      end
    end
  end
end