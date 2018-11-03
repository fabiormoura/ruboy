module Emulator
  module Ppu
    module State
      class ScrollX
        SCROLL_X_RAM_ADDRESS = 0xFF43.freeze

        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end

        def read_value
          @mmu[SCROLL_X_RAM_ADDRESS]
        end
      end
    end
  end
end