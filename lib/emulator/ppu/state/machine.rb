module Emulator
  module Ppu
    module State
      class Machine
        attr_accessor :active_mode
        attr_reader :ppu

        state_machine :state, initial: :oam_search do
          event :oam_search_completed do
            transition [:oam_search] => :pixel_transfer
          end

          event :pixel_transfer_completed do
            transition [:pixel_transfer] => :h_blank
          end

          event :h_blank_completed do
            transition [:h_blank] => :oam_search, if: lambda {|machine| !machine.ppu.lcd_y.v_blank_period?}
            transition [:h_blank] => :v_blank, if: lambda {|machine| machine.ppu.lcd_y.v_blank_period?}
          end

          event :v_blank_completed do
            transition [:v_blank] => :oam_search, if: lambda {|machine| !machine.ppu.lcd_y.v_blank_period?}
          end

          state :oam_search, value: ::Emulator::Ppu::State::Modes::OAM_SEARCH
          state :pixel_transfer, value: ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
          state :h_blank, value: ::Emulator::Ppu::State::Modes::H_BLANK
          state :v_blank, value: ::Emulator::Ppu::State::Modes::V_BLANK
        end

        # @param [::Emulator::Ppu::Ppu] ppu
        def initialize(ppu:)
          @ppu = ppu
          super()
        end
      end
    end
  end
end