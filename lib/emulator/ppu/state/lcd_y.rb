module Emulator
  module Ppu
    module State
      class LcdY
        LCD_Y_RAM_ADDRESS = 0xFF44.freeze
        V_BLANK_START_LINE = 144.freeze
        V_BLANK_END_LINE = 153.freeze

        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end

        def increment
          @mmu[LCD_Y_RAM_ADDRESS] = (@mmu[LCD_Y_RAM_ADDRESS] + 1) % V_BLANK_END_LINE.next
        end

        def read_value
          @mmu[LCD_Y_RAM_ADDRESS]
        end

        def v_blank_period?
          @mmu[LCD_Y_RAM_ADDRESS].between?(V_BLANK_START_LINE, V_BLANK_END_LINE)
        end
      end
    end
  end
end