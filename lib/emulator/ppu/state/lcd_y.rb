module Emulator
  module Ppu
    module State
      class LcdY
        # @param [::Emulator::Mmu] mmu
        def initialize(mmu:)
          @mmu = mmu
        end

        def increment
          @mmu[0xFF44] = (@mmu[0xFF44] + 1) % 154
        end

        def v_blank_period?
          @mmu[0xFF44].between?(144, 153)
        end
      end
    end
  end
end