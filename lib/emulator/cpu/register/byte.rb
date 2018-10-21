module Emulator
  module Cpu
    module Register
      # @param [Integer] value
      # @param [String] label
      class Byte < ::Emulator::Cpu::Register::Register
        def initialize(value: 0x0, label:)
          super(size_in_bits: 8, value: value, label: label)
        end
      end
    end
  end

end