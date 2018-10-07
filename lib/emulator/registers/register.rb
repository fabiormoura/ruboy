module Emulator
  module Registers
    class Register
      def initialize(size_in_bits:, initial_data: 0x0, name:)
        raise Errors::OverflowError if (initial_data >> size_in_bits) > 0
        @data = initial_data
        @size_in_bits = size_in_bits
        @name = name
      end

      def write(data)
        raise Errors::OverflowError, "error updating register #{@name} limited to #{@size_in_bits} bits with value #{data.to_s(2)}" if (data >> @size_in_bits) > 0
        @data = data
      end

      def read
        @data
      end

      def ==(data)
        if data.is_a?(Integer)
          return @data == data
        elsif data.is_a?(Register) && data.class == self.class
          return @data == data.read
        end
        raise NotImplementedError
      end

      def to_s
        "#{@name}: #{@data}"
      end
    end
  end
end