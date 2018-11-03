module Emulator
  module Ppu
    module State
      class FrameBuffer
        WIDTH = 160.freeze
        HEIGHT = 144.freeze

        def initialize
          @data = Array.new(WIDTH * HEIGHT, 0x0)
        end
      end
    end
  end
end