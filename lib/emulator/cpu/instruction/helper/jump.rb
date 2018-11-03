module Emulator
  module Cpu
    module Instruction
      module Helper
        module Jump
          extend ActiveSupport::Concern
          include Stack

          class_methods do
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def jump_to_immediate_word_value(state:, mmu:)
              jump_address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]
              state.pc.write_value(jump_address)
            end

            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def jump_to_signed_byte_offset(state:, mmu:)
              jump_address = signed_byte_value(mmu[state.pc.read_value])
              state.pc.increment
              updated_address = state.pc.read_value
              updated_address += jump_address if !block_given? || yield
              state.pc.write_value(updated_address)
            end

            protected :jump_to_signed_byte_offset

            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def call_address(state:, mmu:)
              jump_address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]

              state.pc.increment(offset: 2)

              if !block_given? || yield
                push_word_value_onto_stack(state: state, mmu: mmu, value: state.pc.read_value)

                state.pc.write_value(jump_address)
              end
            end

            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def return_address(state:, mmu:)
              return unless !block_given? || yield

              jump_address = mmu[state.sp.read_value + 1] << 8 | mmu[state.sp.read_value]

              state.sp.write_value(state.sp.read_value + 2)
              state.pc.write_value(jump_address)
            end

            protected :call_address

            def signed_byte_value(value)
              value > 0b0111_1111 ? (value & 0b0111_1111) - 0b1000_0000 : value
            end

            private :signed_byte_value
          end
        end
      end
    end
  end
end
