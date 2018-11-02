module Emulator
  module Ppu
    module State
      module Modes
        OAM_SEARCH = ::Emulator::Ppu::State::Mode.new(name: 'OAM Search', required_cycles: 80)
        PIXEL_TRANSFER = ::Emulator::Ppu::State::Mode.new(name: 'Pixel Transfer', required_cycles: 172)
        H_BLANK = ::Emulator::Ppu::State::Mode.new(name: 'H-Blank', required_cycles: 204)
        V_BLANK = ::Emulator::Ppu::State::Mode.new(name: 'V-Blank', required_cycles: 80 + 172 + 204)
      end
    end
  end
end