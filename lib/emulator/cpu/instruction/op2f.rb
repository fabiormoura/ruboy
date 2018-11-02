module Emulator
  module Cpu
    module Instruction
      module Op2f
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'CPL', opcode: 0x2F

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          state.a.write_value(~state.a.read_value & 0xFF)
          state.f.toggle_half_carry_flag(true)
          state.f.toggle_subtract_flag(true)
          ::Emulator::Cpu::Instruction::Result.new(cycles: 4)
        end
      end
    end
  end
end
