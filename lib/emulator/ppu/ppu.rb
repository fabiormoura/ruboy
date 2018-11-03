module Emulator
  module Ppu
    class Ppu
      attr_reader :lcd_control, :lcd_status, :lcd_y
      attr_reader :frame_buffer

      # @param [::Emulator::Mmu] mmu
      # @param [::Emulator::BroadcastChannel] channel
      def initialize(mmu:, channel:)
        @machine = ::Emulator::Ppu::State::Machine.new(ppu: self, channel: channel)
        @lcd_control = ::Emulator::Ppu::State::LcdControl.new(mmu: mmu)
        @lcd_status = ::Emulator::Ppu::State::LcdStatus.new(mmu: mmu, channel: channel)
        @lcd_y = ::Emulator::Ppu::State::LcdY.new(mmu: mmu)
        @scroll_x = ::Emulator::Ppu::State::ScrollX.new(mmu: mmu)
        @scroll_y = ::Emulator::Ppu::State::ScrollY.new(mmu: mmu)
        @mmu = mmu
        @cycles = 0

        @frame_buffer = Array.new WIDTH * HEIGHT, 0

        channel.attach(::Emulator::Cpu::Event::CpuTicked, method(:on_cpu_ticked))
      end

      def tick
        return if idle?
        refresh_cycles!

        # LCD Control
        # BIT 6: Window Tile Map Display Select
        #   0: $9800-$9BFF
        #   1: $9C00-$9FFF
        # BIT 5: WINDOW ON/OFF
        # BIT 4: BG & Window Tile Data Select
        #   0: $8800-$97FF
        #   1: $8000-$8FFF <- Same area as OBJ
        # BIT 3: BG Tile Map Display Select
        #   0: $9800-$9BFF
        #   1: $9C00-$9FFF
        # BIT 2: OBJ Size
        # BIT 1: OBJ (Sprite) Enabled
        # BIT 0: BG ON/OFF
        # puts @mmu[0xFF40].to_s(2).rjust(8, '0')

        # BG Pallete
        # puts @mmu[0xFF47].to_s(2).rjust(8, '0')

        # SCY
        # puts @mmu[0xFF42].to_s(16).rjust(2, '0')
        #
        # SCX
        # puts @mmu[0xFF43].to_s(16).rjust(2, '0')
        #
        # VRAM
        # 8000
        # ...
        # ...
        # 9FFF
        #
        # OAM RAM
        # FE00
        # FE04
        # ...
        # ...
        # FE9C

        case @machine.active_mode
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
        @cycles < @machine.active_mode.required_cycles
      end

      private :idle?

      def refresh_cycles!
        @cycles = @cycles % @machine.active_mode.required_cycles
      end

      private :refresh_cycles!

      def tick_oam_search
        @machine.oam_search_completed
      end

      WIDTH = 160.freeze
      HEIGHT = 144.freeze
      BACKGROUND_MAP_WIDTH = BACKGROUND_MAP_HEIGHT = 256.freeze
      TILE_WIDTH = TILE_HEIGHT = 8.freeze
      TILE_PER_LINE_COUNT = 32.freeze
      TILE_BITS_COUNT = 16.freeze

      def tick_pixel_transfer
        background_tile_start_ram_address = @lcd_control.background_tile_start_ram_address
        background_map_start_ram_address = @lcd_control.background_map_start_ram_address
        scroll_x = @scroll_x.read_value
        scroll_y = @scroll_y.read_value
        lcd_y = @lcd_y.read_value
        palette = @mmu[0xFF47]

        WIDTH.times do |viewport_x|
          background_map_x = (scroll_x + viewport_x) % BACKGROUND_MAP_WIDTH
          background_map_y = (scroll_y + lcd_y) % BACKGROUND_MAP_HEIGHT

          tile_index_x = background_map_x / TILE_WIDTH
          tile_index_y = background_map_y / TILE_HEIGHT

          tile_index = tile_index_y * TILE_PER_LINE_COUNT + tile_index_x

          tile_map_address = background_map_start_ram_address + tile_index

          tile_id = @mmu[tile_map_address]

          in_tile_x = background_map_x % TILE_WIDTH
          in_tile_y = background_map_y % TILE_HEIGHT

          tile_offset = background_tile_start_ram_address == 0x8800 ? (signed_byte_value(tile_id) + 128) * TILE_BITS_COUNT : tile_id * TILE_BITS_COUNT

          in_tile_index = in_tile_y * 2
          tile_set_address = background_tile_start_ram_address + tile_offset + in_tile_index

          pixels_data = [@mmu[tile_set_address], @mmu[tile_set_address + 1]]
          pixel_value = extract_pixel_value(pixels_data, in_tile_x)
          pixel_color = (palette >> (pixel_value * 2)) & 0x3
          rgb_color = rgb pixel_color

          position = (WIDTH * lcd_y) + viewport_x
          @frame_buffer[position] = rgb_color
        end
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

      def signed_byte_value(value)
        value > 0b0111_1111 ? (value & 0b0111_1111) - 0b1000_0000 : value
      end

      private :signed_byte_value

      def extract_pixel_value(pixel_data, pixel_index)
        ((bit_value(pixel_data[1], 7 - pixel_index) << 1) | bit_value(pixel_data[0], 7 - pixel_index)) & 0xFF
      end

      def bit_value(value, bit)
        (value >> bit) & 1
      end

      def rgb(color_code)
        case color_code
        when 0
          0xFFFFFFFF
        when 1
          0xFFA8A8A8
        when 2
          0xFF555555
        when 3
          0x00000000
        end
      end
    end
  end
end