module Emulator
  module AddressBlock
    class Cartridge < ::Emulator::AddressBlock::AddressBlock
      # @param [String] rom_path
      def initialize(rom_path:)
        data = IO.binread(rom_path)
        super(size_in_bytes: data.size, item_size_in_bits: 8)
        address = 0x00
        data.each_byte {|value| self[address] = value; address += 0x01}
      end
    end
  end
end