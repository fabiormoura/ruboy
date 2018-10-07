module Emulator
  class Ram < Memory
    def initialize
      super(size_in_bytes: 65_536, item_size_in_bits: 8)
    end
  end
end