module Emulator
  module Ppu
    module State
      class LcdStatus
        LCD_STATUS_BYTE = 0xFF41.freeze
        MODE_FLAG_RESET_MASK = 0b1111_1100.freeze
        OAM_SEARCH_MODE_FLAG_BITS = 0b10.freeze
        PIXEL_TRANSFER_MODE_FLAG_BITS = 0b11.freeze
        H_BLANK_MODE_FLAG_BITS = 0b00.freeze
        V_BLANK_MODE_FLAG_BITS = 0b01.freeze

        # @param [::Emulator::Mmu] mmu
        # @param [::Emulator::BroadcastChannel] channel
        def initialize(mmu:, channel:)
          @mmu = mmu

          channel.attach(::Emulator::Ppu::Event::PpuModeTransitioned, method(:on_ppu_mode_transitioned))
        end

        # @param [::Emulator::Ppu::Event::PpuModeTransitioned] event
        def on_ppu_mode_transitioned(event)
          lcd_status = @mmu[LCD_STATUS_BYTE] & MODE_FLAG_RESET_MASK
          case event.active_mode
          when ::Emulator::Ppu::State::Modes::OAM_SEARCH
            lcd_status |= OAM_SEARCH_MODE_FLAG_BITS
          when ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
            lcd_status |= PIXEL_TRANSFER_MODE_FLAG_BITS
          when ::Emulator::Ppu::State::Modes::H_BLANK
            lcd_status |= H_BLANK_MODE_FLAG_BITS
          when ::Emulator::Ppu::State::Modes::V_BLANK
            lcd_status |= V_BLANK_MODE_FLAG_BITS
          else
            raise NotImplementedError
          end
          @mmu[LCD_STATUS_BYTE] = lcd_status
        end
      end
    end
  end
end