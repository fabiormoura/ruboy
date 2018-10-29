module Emulator
  module Cpu
    module Instruction
      module Helper
        module Jump
          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def jump_to_signed_byte_offset(state:, mmu:)
            current_addr = state.pc.read_value
            addr = current_addr + 1
            addr += signed_byte_value(mmu[current_addr]) if !block_given? || yield
            state.pc.write_value(addr)
          end

          # @param [::Emulator::Cpu::State] state
          # @param [::Emulator::Mmu] mmu
          def call_address(state:, mmu:)
            jump_address = mmu[state.pc.read_value + 1] << 8 | mmu[state.pc.read_value]

            state.pc.increment(offset: 2)

            if !block_given? || yield
              state.sp.write_value(state.sp.read_value - 1)
              mmu[state.sp.read_value] = (state.pc.read_value >> 8) & 0xFF

              state.sp.write_value(state.sp.read_value - 1)
              mmu[state.sp.read_value] = (state.pc.read_value & 0xFF)

              state.pc.write_value(jump_address)
            end
          end

          def signed_byte_value(value)
            value > 0b0111_1111 ? (value & 0b0111_1111) - 0b1000_0000 : value
          end

          private :signed_byte_value
        end
      end
    end
  end
end