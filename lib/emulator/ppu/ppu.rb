module Emulator
  module Ppu
    class Ppu
      attr_reader :lcd_control, :lcd_status, :lcd_y

      state_machine :state, initial: :oam_search do
        event :oam_search_completed do
          transition [:oam_search] => :pixel_transfer
        end

        event :pixel_transfer_completed do
          transition [:pixel_transfer] => :h_blank
        end

        event :h_blank_completed do
          transition [:h_blank] => :oam_search, if: lambda {|ppu| !ppu.lcd_y.v_blank_period?}
          transition [:h_blank] => :v_blank, if: lambda {|ppu| ppu.lcd_y.v_blank_period?}
        end

        event :v_blank_completed do
          transition [:v_blank] => :oam_search, if: lambda {|ppu| !ppu.lcd_y.v_blank_period?}
        end

        state :oam_search do
          def update_state
            # puts "OAM"
            oam_search_completed
          end

          def current_mode
            ::Emulator::Ppu::State::Modes::OAM_SEARCH
          end
        end

        state :pixel_transfer do
          def update_state
            # puts "PIXEL TRANSFER"
            pixel_transfer_completed
          end

          def current_mode
            ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
          end
        end

        state :h_blank do
          def update_state
            # puts "H-BLANK"
            @lcd_y.increment
            h_blank_completed
          end

          def current_mode
            ::Emulator::Ppu::State::Modes::H_BLANK
          end
        end

        state :v_blank do
          def update_state
            # puts "V-BLANK"
            @lcd_y.increment
            v_blank_completed
          end

          def current_mode
            ::Emulator::Ppu::State::Modes::V_BLANK
          end
        end
      end

      # @param [::Emulator::Mmu] mmu
      # @param [::Emulator::BroadcastChannel] channel
      def initialize(mmu:, channel:)
        @lcd_control = ::Emulator::Ppu::State::LcdControl.new(mmu: mmu)
        @lcd_status = ::Emulator::Ppu::State::LcdStatus.new(mmu: mmu)
        @lcd_y = ::Emulator::Ppu::State::LcdY.new(mmu: mmu)
        @mmu = mmu
        @cycles = 0

        channel.attach(::Emulator::Cpu::Event::CpuTicked, method(:on_cpu_ticked))

        super()
      end

      def tick
        return if idle?
        refresh_cycles!
        update_state
      end

      def idle?
        @cycles < current_mode.required_cycles
      end

      private :idle?

      def refresh_cycles!
        @cycles = @cycles % current_mode.required_cycles
      end

      private :refresh_cycles!

      # @param [::Emulator::Cpu::Event::CpuTicked] event
      def on_cpu_ticked(event)
        @cycles += event.cycles
      end
    end
  end
end