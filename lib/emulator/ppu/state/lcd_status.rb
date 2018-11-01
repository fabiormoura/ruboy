module Emulator
  module Ppu
    module State
      class LcdStatus
        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end
      end
    end
  end
end