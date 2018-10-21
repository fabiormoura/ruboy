module Emulator
  module Cpu
    module Register
      class ProgramCounter < ::Emulator::Cpu::Register::Register
        def initialize(value: 0x0)
          super(size_in_bits: 16, value: value, label: "PC")
        end

        def increment
          write_value(read_value + 1)
        end
      end
    end
  end

end