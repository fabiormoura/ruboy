module Emulator
  module Cpu
    module Register
      class Word
        attr_reader :low_register, :high_register

        # @param [::Emulator::Cpu::Register::Byte] low_register
        # @param [::Emulator::Cpu::Register::Byte] high_register
        def initialize(low_register:, high_register:)
          @low_register = low_register
          @high_register = high_register
        end

        # @param [Integer] value
        def write_value(value)
          @low_register.write_value(value & 0x00FF)
          @high_register.write_value(value >> 8)
        end

        def read_value
          ((@high_register.read_value << 8) | @low_register.read_value)
        end

        # @param [Integer] low_value
        # @param [Integer] high_value
        def write_values(low_value:, high_value:)
          @low_register.write_value low_value
          @high_register.write_value high_value
        end

        def ==(other)
          return false unless other.is_a?(::Emulator::Cpu::Register::Word) && other.class == self.class
          @low_register == other.low_register &&
              @high_register == other.high_register
        end
      end
    end
  end

end