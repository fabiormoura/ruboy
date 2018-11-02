module Emulator
  module Cpu
    module Instruction
      module InstructionFunction
        extend ActiveSupport::Concern

        class_methods do
          attr_reader :mnemonic, :opcode

          def mnemonic_definition(mnemonic, opcode:)
            @mnemonic = mnemonic
            @opcode = opcode
          end

          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def execute(state:, mmu:)
            raise NotImplementedError
          end
        end
      end
    end
  end
end
