module Emulator
  module AddressBlocks
    class AddressBlock
      def initialize(size_in_bytes:, item_size_in_bits:, readonly: false)
        @data = Array.new(size_in_bytes, 0x0)
        @item_size_in_bits = item_size_in_bits
        @readonly = readonly
      end

      def []=(position, data)
        raise Errors::ReadonlyAddressBlockError, "address block position #{position} is not writable" if @readonly
        validate_position!(position)
        validate_data!(data)
        @data[position] = data
      end

      def reset
        @data = Array.new(@data.size, 0x0)
      end

      def [](position)
        position = position.read if position.is_a?(Emulator::Registers::Register)
        validate_position!(position)
        @data[position]
      end

      # @param [String] data
      def write_binary(data)
        position = 0
        data.each_byte do |byte|
          self[position] = byte
          position += 1
        end
      end

      def to_s
        "#{@data}"
      end

      def validate_position!(position)
        raise Errors::OverflowError,
              "invalid position. value #{position} has to be between [0,#{@data.size - 1}]" unless position >= 0 && position < @data.size
      end

      private :validate_position!

      def validate_data!(data)
        raise OverflowError, "invalid data #{data.to_s(16)}. It has to be less than #{@item_size_in_bits} bits" unless (data >> @item_size_in_bits) == 0
      end

      private :validate_data!
    end
  end
end