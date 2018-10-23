module Emulator
  module Cpu
    module Register
      class Flags < ::Emulator::Cpu::Register::Byte
        CARRY_BIT = 4
        HALF_CARRY_BIT = 5
        SUBTRACT_BIT = 6
        ZERO_BIT = 7

        def initialize
          super(label: 'F')
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_zero_flag(enable)
          toggle_bit(enable, ZERO_BIT)
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_subtract_flag(enable)
          toggle_bit(enable, SUBTRACT_BIT)
        end

        # https://robdor.com/2016/08/10/gameboy-emulator-half-carry-flag/
        # @param [TrueClass|FalseClass] enable
        def toggle_half_carry_flag(enable)
          toggle_bit(enable, HALF_CARRY_BIT)
        end

        # @param [TrueClass|FalseClass] enable
        def toggle_carry_flag(enable)
          toggle_bit(enable, CARRY_BIT)
        end

        # @@return [TrueClass|FalseClass]
        def carry_flag_enabled?
          bit_enabled?(CARRY_BIT)
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

        # @param [Integer] bit
        def bit_enabled?(bit)
          (read_value >> bit) & 0x1 != 0x0
        end
      end
    end
  end

end