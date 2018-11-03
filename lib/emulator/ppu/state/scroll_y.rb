module Emulator
  module Ppu
    module State
      class ScrollY
        SCROLL_Y_RAM_ADDRESS = 0xFF42.freeze

        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end

        def read_value
          @mmu[SCROLL_Y_RAM_ADDRESS]
        end
      end
    end
  end
end