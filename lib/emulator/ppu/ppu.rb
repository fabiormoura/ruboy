module Emulator
  module Ppu
    class Ppu
      attr_reader :lcd_control, :lcd_status, :lcd_y

      # @param [::Emulator::Mmu] mmu
      # @param [::Emulator::BroadcastChannel] channel
      def initialize(mmu:, channel:)
        @machine = ::Emulator::Ppu::State::Machine.new(ppu: self)
        @lcd_control = ::Emulator::Ppu::State::LcdControl.new(mmu: mmu)
        @lcd_status = ::Emulator::Ppu::State::LcdStatus.new(mmu: mmu)
        @lcd_y = ::Emulator::Ppu::State::LcdY.new(mmu: mmu)
        @mmu = mmu
        @cycles = 0

        channel.attach(::Emulator::Cpu::Event::CpuTicked, method(:on_cpu_ticked))
      end

      def tick
        return if idle?
        refresh_cycles!

        case @machine.state
        when ::Emulator::Ppu::State::Modes::OAM_SEARCH
          tick_oam_search
        when ::Emulator::Ppu::State::Modes::PIXEL_TRANSFER
          tick_pixel_transfer
        when ::Emulator::Ppu::State::Modes::H_BLANK
          tick_h_blank
        when ::Emulator::Ppu::State::Modes::V_BLANK
          tick_v_blank
        else
          raise NotImplementedError
        end
      end

      def idle?
        @cycles < @machine.state.required_cycles
      end

      private :idle?

      def refresh_cycles!
        @cycles = @cycles % @machine.state.required_cycles
      end

      private :refresh_cycles!

      def tick_oam_search
        @machine.oam_search_completed
      end

      def tick_pixel_transfer
        @machine.pixel_transfer_completed
      end

      def tick_h_blank
        @lcd_y.increment
        @machine.h_blank_completed
      end

      def tick_v_blank
        @lcd_y.increment
        @machine.v_blank_completed
      end

      # @param [::Emulator::Cpu::Event::CpuTicked] event
      def on_cpu_ticked(event)
        @cycles += event.cycles
      end
    end
  end
end