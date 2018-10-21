module Emulator
  module Cpu
    module Register
      class Register
        attr_reader :size_in_bits, :label

        # @param [Integer] size_in_bits
        # @param [Integer] value
        # @param [String] label
        def initialize(size_in_bits:, value: 0x0, label:)
          raise Errors::OverflowError if (value >> size_in_bits) > 0
          @value = value
          @size_in_bits = size_in_bits
          @label = label
        end

        # @param [Integer] value
        def write_value(value)
          raise Errors::OverflowError, "error updating register #{@label} limited to #{@size_in_bits} bits with value #{value.to_s(2)}" if (value >> @size_in_bits) > 0
          @value = value
        end

        def read_value
          @value
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Cpu::Register::Register) && other.class == self.class
          @value == other.read_value &&
              @size_in_bits == other.size_in_bits &&
              @label == other.label
        end

        def to_s
          pretty_label = @label.rjust(2, ' ')
          hex_value = "0x#{@value.to_s(16).upcase.rjust(size_in_bits / 4, '0')}"
          bin_value = "#{@value.to_s(2).rjust(size_in_bits, '0')}"

          "#{pretty_label}: #{hex_value} (#{bin_value})"
        end
      end
    end
  end
end