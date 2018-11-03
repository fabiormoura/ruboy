module Emulator
  class Mmu
    V_RAM_START_ADDRESS = 0x8000.freeze
    V_RAM_END_ADDRESS = 0x9FFF.freeze
    IO_START_ADDRESS = 0xFF00.freeze
    IO_END_ADDRESS = 0xFF7F.freeze
    H_RAM_START_ADDRESS = 0xFF80.freeze
    H_RAM_END_ADDRESS = 0xFFFE.freeze
    BOOT_ROM_STATUS_ADDRESS = (0xFF50 - IO_START_ADDRESS).freeze
    BOOT_ROM_START_ADDRESS = 0x0000.freeze
    BOOT_ROM_END_ADDRESS = 0x00FF.freeze
    CARTRIDGE_BANK_0_START_ADDRESS = 0x0000.freeze
    CARTRIDGE_BANK_0_END_ADDRESS = 0x3FFF.freeze

    # @param [::Emulator::AddressBlock::AddressBlock] cartridge
    def initialize(cartridge:)
      @boot_room = ::Emulator::AddressBlock::BootRom.new
      @vram = ::Emulator::AddressBlock::Vram.new
      @io = ::Emulator::AddressBlock::Io.new
      @cartridge = cartridge
      @hram = ::Emulator::AddressBlock::Hram.new
    end

    def []=(address, data)
      if address.between?(V_RAM_START_ADDRESS, V_RAM_END_ADDRESS)
        @vram[address - V_RAM_START_ADDRESS] = data
      elsif address.between?(IO_START_ADDRESS, IO_END_ADDRESS)
        @io[address - IO_START_ADDRESS] = data
      elsif address.between?(H_RAM_START_ADDRESS, H_RAM_END_ADDRESS)
        @hram[address - H_RAM_START_ADDRESS] = data
      else
        puts address.to_s(16).rjust(4, '0')
        raise NotImplementedError
      end
    end

    # @param [Integer] address
    def [](address)
      if address.between?(BOOT_ROM_START_ADDRESS, BOOT_ROM_END_ADDRESS) && boot_rom_enabled?
        @boot_room[address]
      elsif address.between?(CARTRIDGE_BANK_0_START_ADDRESS, CARTRIDGE_BANK_0_END_ADDRESS)
        @cartridge[address]
      elsif address.between?(V_RAM_START_ADDRESS, V_RAM_END_ADDRESS)
        @vram[address - V_RAM_START_ADDRESS]
      elsif address.between?(IO_START_ADDRESS, IO_END_ADDRESS)
        @io[address - IO_START_ADDRESS.freeze]
      elsif address.between?(H_RAM_START_ADDRESS, H_RAM_END_ADDRESS)
        @hram[address - H_RAM_START_ADDRESS]
      else
        puts address.to_s(16).rjust(4, '0')
        raise NotImplementedError
      end
    end

    def boot_rom_enabled?
      @io[BOOT_ROM_STATUS_ADDRESS] == 0x00
    end

    private :boot_rom_enabled?
  end
end