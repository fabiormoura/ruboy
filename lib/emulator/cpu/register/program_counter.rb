module Emulator
  module Cpu
    module Register
      class ProgramCounter < ::Emulator::Cpu::Register::Register
        def initialize(value: 0x0)
          super(size_in_bits: 16, value: value, label: 'PC')
        end

        def increment(offset: 1)
          write_value(read_value + offset)
        end
      end
    end
  end

end