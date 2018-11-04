module Emulator
  module Cpu
    module Instruction
      module Op34
        include ::Emulator::Cpu::Instruction::InstructionFunction
        include ::Emulator::Cpu::Instruction::Helper::Arithmetic

        mnemonic_definition 'INC (HL)', opcode: 0x34

        RESULT = ::Emulator::Cpu::Instruction::Result.new(cycles: 12).freeze

        # @param [::Emulator::Cpu::State] state
        # @param [::Emulator::Mmu] mmu
        def self.execute(state:, mmu:)
          addr = state.hl.read_value
          value = mmu[addr]
          mmu[addr] = value + 1
          updated_value = mmu[addr]

          ::Emulator::Cpu::Instruction::Helper::Flags::Increment.update_register_flags(state: state, value: value, updated_value: updated_value)
          RESULT
        end
      end
    end
  end
end
