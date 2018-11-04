module Emulator
  module Cpu
    module Instruction
      module Opbe
        include ::Emulator::Cpu::Instruction::InstructionFunction

        mnemonic_definition 'CP (HL)', opcode: 0xBE

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 8)

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          operand_value = mmu[state.hl.read_value]

          subtracted_value = (state.a.read_value - operand_value) & 0xFF

          ::Emulator::Cpu::Instruction::Helper::Flags::Subtraction.update_register_flags(state: state, operand_value: operand_value, subtracted_value: subtracted_value)
          RESULT
        end
      end
    end
  end
end
