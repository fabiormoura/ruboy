module Emulator
  module Cpu
    module Register
      class Flags < ::Emulator::Cpu::Register::Byte
        def initialize
          super(label: 'F')
        end
      end
    end
  end

end