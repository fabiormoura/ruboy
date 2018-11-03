module Emulator
  module AddressBlock
    class Io < ::Emulator::AddressBlock::AddressBlock
      def initialize
        super(size_in_bytes: 8 * 127, item_size_in_bits: 8)
      end
    end
  end
end