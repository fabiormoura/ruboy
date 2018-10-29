module Emulator
  module Cpu
    class Cpu
      INSTRUCTIONS = [
          ::Emulator::Cpu::Instruction::Op00.new,
          ::Emulator::Cpu::Instruction::Op01.new,
          ::Emulator::Cpu::Instruction::Op02.new,
          ::Emulator::Cpu::Instruction::Op03.new,
          ::Emulator::Cpu::Instruction::Op04.new,
          ::Emulator::Cpu::Instruction::Op05.new,
          ::Emulator::Cpu::Instruction::Op06.new,
          ::Emulator::Cpu::Instruction::Op07.new,
          ::Emulator::Cpu::Instruction::Op08.new,
          ::Emulator::Cpu::Instruction::Op09.new,
          ::Emulator::Cpu::Instruction::Op0a.new,
          ::Emulator::Cpu::Instruction::Op0b.new,
          ::Emulator::Cpu::Instruction::Op0c.new,
          ::Emulator::Cpu::Instruction::Op0d.new,
          ::Emulator::Cpu::Instruction::Op0e.new,
          ::Emulator::Cpu::Instruction::Op0f.new,
          # TODO: ::Emulator::Cpu::Instruction::Op10.new,
          ::Emulator::Cpu::Instruction::Op11.new,
          ::Emulator::Cpu::Instruction::Op12.new,
          ::Emulator::Cpu::Instruction::Op13.new,
          ::Emulator::Cpu::Instruction::Op14.new,
          ::Emulator::Cpu::Instruction::Op15.new,
          ::Emulator::Cpu::Instruction::Op16.new,
          ::Emulator::Cpu::Instruction::Op17.new,
          ::Emulator::Cpu::Instruction::Op18.new,
          ::Emulator::Cpu::Instruction::Op19.new,
          ::Emulator::Cpu::Instruction::Op1a.new,
          ::Emulator::Cpu::Instruction::Op1b.new,
          ::Emulator::Cpu::Instruction::Op1c.new,
          ::Emulator::Cpu::Instruction::Op1d.new,
          ::Emulator::Cpu::Instruction::Op1e.new,
          ::Emulator::Cpu::Instruction::Op1f.new,
          ::Emulator::Cpu::Instruction::Op20.new,
          ::Emulator::Cpu::Instruction::Op21.new,
          ::Emulator::Cpu::Instruction::Op22.new,
          ::Emulator::Cpu::Instruction::Op23.new,
          ::Emulator::Cpu::Instruction::Op24.new,
          ::Emulator::Cpu::Instruction::Op25.new,
          ::Emulator::Cpu::Instruction::Op26.new,
          # TODO: ::Emulator::Cpu::Instruction::Op27.new,
          ::Emulator::Cpu::Instruction::Op28.new,
          ::Emulator::Cpu::Instruction::Op29.new,
          ::Emulator::Cpu::Instruction::Op2a.new,
          ::Emulator::Cpu::Instruction::Op2b.new,
          ::Emulator::Cpu::Instruction::Op2c.new,
          ::Emulator::Cpu::Instruction::Op2d.new,
          ::Emulator::Cpu::Instruction::Op2e.new,
          ::Emulator::Cpu::Instruction::Op2f.new,
          ::Emulator::Cpu::Instruction::Op30.new,
          ::Emulator::Cpu::Instruction::Op31.new,
          ::Emulator::Cpu::Instruction::Op32.new,
          ::Emulator::Cpu::Instruction::Op33.new,
          ::Emulator::Cpu::Instruction::Op34.new,
          ::Emulator::Cpu::Instruction::Op35.new,
          ::Emulator::Cpu::Instruction::Op36.new,
          ::Emulator::Cpu::Instruction::Op37.new,
          ::Emulator::Cpu::Instruction::Op38.new,
          ::Emulator::Cpu::Instruction::Op39.new,
          ::Emulator::Cpu::Instruction::Op3a.new,
          ::Emulator::Cpu::Instruction::Op3b.new,
          ::Emulator::Cpu::Instruction::Op3c.new,
          ::Emulator::Cpu::Instruction::Op3d.new,
          ::Emulator::Cpu::Instruction::Op3e.new,
          ::Emulator::Cpu::Instruction::Op3f.new,
          ::Emulator::Cpu::Instruction::Op40.new,
          ::Emulator::Cpu::Instruction::Op41.new,
          ::Emulator::Cpu::Instruction::Op42.new,
          ::Emulator::Cpu::Instruction::Op43.new,
          ::Emulator::Cpu::Instruction::Op44.new,
          ::Emulator::Cpu::Instruction::Op45.new,
          ::Emulator::Cpu::Instruction::Op46.new,
          ::Emulator::Cpu::Instruction::Op47.new,
          ::Emulator::Cpu::Instruction::Op48.new,
          ::Emulator::Cpu::Instruction::Op49.new,
          ::Emulator::Cpu::Instruction::Op4a.new,
          ::Emulator::Cpu::Instruction::Op4b.new,
          ::Emulator::Cpu::Instruction::Op4c.new,
          ::Emulator::Cpu::Instruction::Op4d.new,
          ::Emulator::Cpu::Instruction::Op4e.new,
          ::Emulator::Cpu::Instruction::Op4f.new,
          ::Emulator::Cpu::Instruction::Op50.new,
          ::Emulator::Cpu::Instruction::Op51.new,
          ::Emulator::Cpu::Instruction::Op52.new,
          ::Emulator::Cpu::Instruction::Op53.new,
          ::Emulator::Cpu::Instruction::Op54.new,
          ::Emulator::Cpu::Instruction::Op55.new,
          ::Emulator::Cpu::Instruction::Op56.new,
          ::Emulator::Cpu::Instruction::Op57.new,
          ::Emulator::Cpu::Instruction::Op58.new,
          ::Emulator::Cpu::Instruction::Op59.new,
          ::Emulator::Cpu::Instruction::Op5a.new,
          ::Emulator::Cpu::Instruction::Op5b.new,
          ::Emulator::Cpu::Instruction::Op5c.new,
          ::Emulator::Cpu::Instruction::Op5d.new,
          ::Emulator::Cpu::Instruction::Op5e.new,
          ::Emulator::Cpu::Instruction::Op5f.new,
          ::Emulator::Cpu::Instruction::Op60.new,
          ::Emulator::Cpu::Instruction::Op61.new,
          ::Emulator::Cpu::Instruction::Op62.new,
          ::Emulator::Cpu::Instruction::Op63.new,
          ::Emulator::Cpu::Instruction::Op64.new,
          ::Emulator::Cpu::Instruction::Op65.new,
          ::Emulator::Cpu::Instruction::Op66.new,
          ::Emulator::Cpu::Instruction::Op67.new,
          ::Emulator::Cpu::Instruction::Op68.new,
          ::Emulator::Cpu::Instruction::Op69.new,
          ::Emulator::Cpu::Instruction::Op6a.new,
          ::Emulator::Cpu::Instruction::Op6b.new,
          ::Emulator::Cpu::Instruction::Op6c.new,
          ::Emulator::Cpu::Instruction::Op6d.new,
          ::Emulator::Cpu::Instruction::Op6e.new,
          ::Emulator::Cpu::Instruction::Op6e.new,
          ::Emulator::Cpu::Instruction::Op6f.new,
          ::Emulator::Cpu::Instruction::Op70.new,
          ::Emulator::Cpu::Instruction::Op71.new,
          ::Emulator::Cpu::Instruction::Op72.new,
          ::Emulator::Cpu::Instruction::Op73.new,
          ::Emulator::Cpu::Instruction::Op74.new,
          ::Emulator::Cpu::Instruction::Op75.new,
          # TODO: ::Emulator::Cpu::Instruction::Op76.new,
          ::Emulator::Cpu::Instruction::Op77.new,
          ::Emulator::Cpu::Instruction::Op78.new,
          ::Emulator::Cpu::Instruction::Op79.new,
          ::Emulator::Cpu::Instruction::Op7a.new,
          ::Emulator::Cpu::Instruction::Op7b.new,
          ::Emulator::Cpu::Instruction::Op7c.new,
          ::Emulator::Cpu::Instruction::Op7d.new,
          ::Emulator::Cpu::Instruction::Op7e.new,
          ::Emulator::Cpu::Instruction::Op7f.new,
          ::Emulator::Cpu::Instruction::Opa8.new,
          ::Emulator::Cpu::Instruction::Opa9.new,
          ::Emulator::Cpu::Instruction::Opaa.new,
          ::Emulator::Cpu::Instruction::Opab.new,
          ::Emulator::Cpu::Instruction::Opac.new,
          ::Emulator::Cpu::Instruction::Opad.new,
          ::Emulator::Cpu::Instruction::Opaf.new,
          ::Emulator::Cpu::Instruction::Opcb7c.new,
          ::Emulator::Cpu::Instruction::Opcc.new,
          ::Emulator::Cpu::Instruction::Opcd.new,
          ::Emulator::Cpu::Instruction::Ope0.new,
          ::Emulator::Cpu::Instruction::Ope2.new
      ].freeze

      # @param [Emulator::Mmu] mmu
      # @param [Emulator::Cpu::State] state
      def initialize(mmu:, state:)
        @state = state
        @mmu = mmu
        @instructions = INSTRUCTIONS.map {|instruction| [instruction.instruction_id, instruction]}.to_h
      end

      def tick
        opcode = fetch_opcode
        # puts @state
        instruction = @instructions[::Emulator::Cpu::Instruction::InstructionId.new(opcode)]
        if instruction.nil?
          puts "0x#{opcode.to_s(16).rjust(1, '0')}"
          raise NotImplementedError
        end

        # puts instruction.to_s

        instruction.execute(mmu: @mmu, state: @state)
      end

      def fetch_opcode
        opcode = @mmu[@state.pc.read_value]
        @state.pc.increment
        return opcode unless opcode == 0xCB

        opcode = opcode << 8 | @mmu[@state.pc.read_value]
        @state.pc.increment
        opcode
      end

      private :fetch_opcode
    end
  end
end