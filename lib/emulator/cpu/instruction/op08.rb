module Emulator
  module Cpu
    module Instruction
      module Op08
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'LD (a16),SP', opcode: 0x08

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 20)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          low_addr = mmu[state.pc.read_value]
          state.pc.increment
          high_addr = mmu[state.pc.read_value]
          state.pc.increment

          addr = high_addr << 8 | low_addr

          low_value = state.sp.read_value & 0xFF
          high_value = state.sp.read_value >> 8
          mmu[addr] = low_value
          mmu[addr + 1] = high_value
          RESULT
        end
      end
    end
  end
end
