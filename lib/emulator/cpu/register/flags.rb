module Emulator
  module Cpu
    module Register
      class Flags < ::Emulator::Cpu::Register::Byte
        def initialize
          super(label: 'F')
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_zero_flag(enable)
          toggle_bit(enable, 7)
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_subtract_flag(enable)
          toggle_bit(enable, 6)
        end

        # https://robdor.com/2016/08/10/gameboy-emulator-half-carry-flag/
        # @param [TrueClass|FalseClass] enable
        def toggle_half_carry_flag(enable)
          toggle_bit(enable, 5)
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_carry_flag(enable)
          toggle_bit(enable, 4)
        end

        # @param [TrueClass|FalseClass] enable
        # @param [Integer] bit
        def toggle_bit(enable, bit)
          enable ? enable_bit(bit) : disable_bit(bit)
        end

        private :toggle_bit

        # @param [Integer] bit
        def enable_bit(bit)
          write_value(read_value | (1 << bit))
        end

        private :enable_bit

        # @param [Integer] bit
        def disable_bit(bit)
          write_value(read_value & ~(1 << bit))
        end

        private :disable_bit

        # set_flag_zero(reg.value() == 0);
        # set_flag_subtract(false);
        # set_flag_half_carry((reg.value() & 0x0F) == 0x00);
      end
    end
  end

end