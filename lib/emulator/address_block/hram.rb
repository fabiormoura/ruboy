module Emulator
  module AddressBlock
    class Hram < ::Emulator::AddressBlock::AddressBlock
      def initialize
        super(size_in_bytes: 8 * 126, item_size_in_bits: 8)
      end
    end
  end
end