module Emulator
  module Cpu
    module Instruction
      module Helper
        module Load
          extend ActiveSupport::Concern

          class_methods do
            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_word_register_from_pc_position_address(register:, state:, mmu:)
              low_value = mmu[state.pc.read_value]
              state.pc.increment
              high_value = mmu[state.pc.read_value]
              state.pc.increment

              state.send(register).write_values(low_value: low_value, high_value: high_value)
            end

            protected :load_word_register_from_pc_position_address

            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_byte_register_from_pc_position_address(register:, state:, mmu:)
              value = mmu[state.pc.read_value]
              state.pc.increment

              state.send(register).write_value(value)
            end

            protected :load_byte_register_from_pc_position_address

            # @param [Integer] target_address
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_target_address_from_pc_position_address(target_address:, state:, mmu:)
              value = mmu[state.pc.read_value]
              state.pc.increment

              mmu[target_address] = value
            end

            protected :load_target_address_from_pc_position_address

            # @param [Symbol] register
            # @param [Symbol] address_register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_word_register_address_from_byte_register(address_register:, register:, state:, mmu:)
              address = state.send(address_register).read_value
              load_address_from_byte_register(address: address, register: register, state: state, mmu: mmu)
            end

            protected :load_word_register_address_from_byte_register

            # @param [Integer] address
            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_address_from_byte_register(address:, register:, state:, mmu:)
              mmu[address] = state.send(register).read_value
            end

            protected :load_address_from_byte_register

            # @param [Integer] address
            # @param [Symbol] register
            # @param [::Emulator::Cpu::State] state
            # @param [::Emulator::Mmu] mmu
            def load_byte_register_from_address(address:, register:, state:, mmu:)
              state.send(register).write_value mmu[address]
            end

            protected :load_byte_register_from_address
          end
        end
      end
    end
  end
end
