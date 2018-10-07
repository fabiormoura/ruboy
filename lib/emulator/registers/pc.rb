module Emulator
  module Registers
    class ProgramCounter < Register
      def initialize
        super(size_in_bits: 16, initial_data: 0x0, name: "PC")
      end
    end
  end
end