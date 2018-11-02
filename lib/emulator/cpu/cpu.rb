module Emulator
  module Cpu
    class Cpu
      # @param [::Emulator::Mmu] mmu
      # @param [::Emulator::Cpu::State] state
      # @param [::Emulator::BroadcastChannel] channel
      def initialize(mmu:, state:, channel:)
        @state = state
        @mmu = mmu
        @channel = channel
        @instructions_table = ::Emulator::Cpu::Instruction::InstructionsTable.new
      end

      def tick
        opcode = fetch_opcode
        instruction = @instructions_table[opcode]

        instruction_result = instruction.execute(mmu: @mmu, state: @state)

        @channel.announce(::Emulator::Cpu::Event::CpuTicked.new(opcode: opcode, cycles: instruction_result.cycles, state: @state))
      end

      def fetch_opcode
        opcode = @mmu[@state.pc.read_value]
        if opcode == 0xCB
          opcode = (opcode << 8) | @mmu[@state.pc.read_value + 1]
          @state.pc.increment(offset: 2)
        else
          @state.pc.increment
        end
        opcode
      end

      private :fetch_opcode
    end
  end
end