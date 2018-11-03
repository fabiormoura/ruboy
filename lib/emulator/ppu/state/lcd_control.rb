module Emulator
  module Ppu
    module State
      class LcdControl
        LCD_CONTROL_RAM_ADDRESS = 0xFF40.freeze

        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end

        def background_tile_start_ram_address
          @mmu[LCD_CONTROL_RAM_ADDRESS] & 0b0001_0000 == 0x0 ? 0x8800 : 0x8000
        end

        def background_map_start_ram_address
          @mmu[LCD_CONTROL_RAM_ADDRESS] & 0b0000_1000 == 0x0 ? 0x9800 : 0x9C00
        end
      end
    end
  end
end