module Emulator
  class Cpu
    # @param [Emulator::Registers::ProgramCounter] pc
    # @param [Emulator::AddressBlocks::BootRom] boot_rom
    def initialize(pc:, boot_rom:)
      @pc = pc
      @boot_rom = boot_rom
    end
  end
end