module Emulator
  module AddressBlock
    class AddressBlock
      def initialize(size_in_bytes:, item_size_in_bits:)
        @data = Array.new(size_in_bytes, 0x0)
        @item_size_in_bits = item_size_in_bits
      end

      def []=(address, data)
        validate_address!(address)
        validate_data!(data)
        @data[address] = data
      end

      def reset
        @data = Array.new(@data.size, 0x0)
      end

      def [](address)
        validate_address!(address)
        @data[address]
      end

      def to_s
        "#{@data}"
      end

      def validate_address!(position)
        raise ::Emulator::Error::OverflowError,
              "invalid position. value #{position} has to be between [0,#{@data.size - 1}]" unless position >= 0 && position < @data.size
      end

      private :validate_address!

      def validate_data!(data)
        raise ::Emulator::Error::OverflowError, "invalid data #{data.to_s(16)}. It has to be less than #{@item_size_in_bits} bits" unless (data >> @item_size_in_bits) == 0
      end

      private :validate_data!
    end
  end
end