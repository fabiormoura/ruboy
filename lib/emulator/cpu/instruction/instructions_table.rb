module Emulator
  module Cpu
    module Instruction
      class InstructionsTable
        INSTRUCTIONS = [
            ::Emulator::Cpu::Instruction::Op00,
            ::Emulator::Cpu::Instruction::Op01,
            ::Emulator::Cpu::Instruction::Op02,
            ::Emulator::Cpu::Instruction::Op03,
            ::Emulator::Cpu::Instruction::Op04,
            ::Emulator::Cpu::Instruction::Op05,
            ::Emulator::Cpu::Instruction::Op06,
            ::Emulator::Cpu::Instruction::Op07,
            ::Emulator::Cpu::Instruction::Op08,
            ::Emulator::Cpu::Instruction::Op09,
            ::Emulator::Cpu::Instruction::Op0a,
            ::Emulator::Cpu::Instruction::Op0b,
            ::Emulator::Cpu::Instruction::Op0c,
            ::Emulator::Cpu::Instruction::Op0d,
            ::Emulator::Cpu::Instruction::Op0e,
            ::Emulator::Cpu::Instruction::Op0f,
            # TODO: ::Emulator::Cpu::Instruction::Op10.new,
            ::Emulator::Cpu::Instruction::Op11,
            ::Emulator::Cpu::Instruction::Op12,
            ::Emulator::Cpu::Instruction::Op13,
            ::Emulator::Cpu::Instruction::Op14,
            ::Emulator::Cpu::Instruction::Op15,
            ::Emulator::Cpu::Instruction::Op16,
            ::Emulator::Cpu::Instruction::Op17,
            ::Emulator::Cpu::Instruction::Op18,
            ::Emulator::Cpu::Instruction::Op19,
            ::Emulator::Cpu::Instruction::Op1a,
            ::Emulator::Cpu::Instruction::Op1b,
            ::Emulator::Cpu::Instruction::Op1c,
            ::Emulator::Cpu::Instruction::Op1d,
            ::Emulator::Cpu::Instruction::Op1e,
            ::Emulator::Cpu::Instruction::Op1f,
            ::Emulator::Cpu::Instruction::Op20,
            ::Emulator::Cpu::Instruction::Op21,
            ::Emulator::Cpu::Instruction::Op22,
            ::Emulator::Cpu::Instruction::Op23,
            ::Emulator::Cpu::Instruction::Op24,
            ::Emulator::Cpu::Instruction::Op25,
            ::Emulator::Cpu::Instruction::Op26,
            # TODO: ::Emulator::Cpu::Instruction::Op27.new,
            ::Emulator::Cpu::Instruction::Op28,
            ::Emulator::Cpu::Instruction::Op29,
            ::Emulator::Cpu::Instruction::Op2a,
            ::Emulator::Cpu::Instruction::Op2b,
            ::Emulator::Cpu::Instruction::Op2c,
            ::Emulator::Cpu::Instruction::Op2d,
            ::Emulator::Cpu::Instruction::Op2e,
            ::Emulator::Cpu::Instruction::Op2f,
            ::Emulator::Cpu::Instruction::Op30,
            ::Emulator::Cpu::Instruction::Op31,
            ::Emulator::Cpu::Instruction::Op32,
            ::Emulator::Cpu::Instruction::Op33,
            ::Emulator::Cpu::Instruction::Op34,
            ::Emulator::Cpu::Instruction::Op35,
            ::Emulator::Cpu::Instruction::Op36,
            ::Emulator::Cpu::Instruction::Op37,
            ::Emulator::Cpu::Instruction::Op38,
            ::Emulator::Cpu::Instruction::Op39,
            ::Emulator::Cpu::Instruction::Op3a,
            ::Emulator::Cpu::Instruction::Op3b,
            ::Emulator::Cpu::Instruction::Op3c,
            ::Emulator::Cpu::Instruction::Op3d,
            ::Emulator::Cpu::Instruction::Op3e,
            ::Emulator::Cpu::Instruction::Op3f,
            ::Emulator::Cpu::Instruction::Op40,
            ::Emulator::Cpu::Instruction::Op41,
            ::Emulator::Cpu::Instruction::Op42,
            ::Emulator::Cpu::Instruction::Op43,
            ::Emulator::Cpu::Instruction::Op44,
            ::Emulator::Cpu::Instruction::Op45,
            ::Emulator::Cpu::Instruction::Op46,
            ::Emulator::Cpu::Instruction::Op47,
            ::Emulator::Cpu::Instruction::Op48,
            ::Emulator::Cpu::Instruction::Op49,
            ::Emulator::Cpu::Instruction::Op4a,
            ::Emulator::Cpu::Instruction::Op4b,
            ::Emulator::Cpu::Instruction::Op4c,
            ::Emulator::Cpu::Instruction::Op4d,
            ::Emulator::Cpu::Instruction::Op4e,
            ::Emulator::Cpu::Instruction::Op4f,
            ::Emulator::Cpu::Instruction::Op50,
            ::Emulator::Cpu::Instruction::Op51,
            ::Emulator::Cpu::Instruction::Op52,
            ::Emulator::Cpu::Instruction::Op53,
            ::Emulator::Cpu::Instruction::Op54,
            ::Emulator::Cpu::Instruction::Op55,
            ::Emulator::Cpu::Instruction::Op56,
            ::Emulator::Cpu::Instruction::Op57,
            ::Emulator::Cpu::Instruction::Op58,
            ::Emulator::Cpu::Instruction::Op59,
            ::Emulator::Cpu::Instruction::Op5a,
            ::Emulator::Cpu::Instruction::Op5b,
            ::Emulator::Cpu::Instruction::Op5c,
            ::Emulator::Cpu::Instruction::Op5d,
            ::Emulator::Cpu::Instruction::Op5e,
            ::Emulator::Cpu::Instruction::Op5f,
            ::Emulator::Cpu::Instruction::Op60,
            ::Emulator::Cpu::Instruction::Op61,
            ::Emulator::Cpu::Instruction::Op62,
            ::Emulator::Cpu::Instruction::Op63,
            ::Emulator::Cpu::Instruction::Op64,
            ::Emulator::Cpu::Instruction::Op65,
            ::Emulator::Cpu::Instruction::Op66,
            ::Emulator::Cpu::Instruction::Op67,
            ::Emulator::Cpu::Instruction::Op68,
            ::Emulator::Cpu::Instruction::Op69,
            ::Emulator::Cpu::Instruction::Op6a,
            ::Emulator::Cpu::Instruction::Op6b,
            ::Emulator::Cpu::Instruction::Op6c,
            ::Emulator::Cpu::Instruction::Op6d,
            ::Emulator::Cpu::Instruction::Op6e,
            ::Emulator::Cpu::Instruction::Op6e,
            ::Emulator::Cpu::Instruction::Op6f,
            ::Emulator::Cpu::Instruction::Op70,
            ::Emulator::Cpu::Instruction::Op71,
            ::Emulator::Cpu::Instruction::Op72,
            ::Emulator::Cpu::Instruction::Op73,
            ::Emulator::Cpu::Instruction::Op74,
            ::Emulator::Cpu::Instruction::Op75,
            # TODO: ::Emulator::Cpu::Instruction::Op76.new,
            ::Emulator::Cpu::Instruction::Op77,
            ::Emulator::Cpu::Instruction::Op78,
            ::Emulator::Cpu::Instruction::Op79,
            ::Emulator::Cpu::Instruction::Op7a,
            ::Emulator::Cpu::Instruction::Op7b,
            ::Emulator::Cpu::Instruction::Op7c,
            ::Emulator::Cpu::Instruction::Op7d,
            ::Emulator::Cpu::Instruction::Op7e,
            ::Emulator::Cpu::Instruction::Op7f,
            ::Emulator::Cpu::Instruction::Op86,
            ::Emulator::Cpu::Instruction::Op90,
            ::Emulator::Cpu::Instruction::Opa8,
            ::Emulator::Cpu::Instruction::Opa9,
            ::Emulator::Cpu::Instruction::Opaa,
            ::Emulator::Cpu::Instruction::Opab,
            ::Emulator::Cpu::Instruction::Opac,
            ::Emulator::Cpu::Instruction::Opad,
            ::Emulator::Cpu::Instruction::Opaf,
            ::Emulator::Cpu::Instruction::Opbe,
            ::Emulator::Cpu::Instruction::Opc0,
            ::Emulator::Cpu::Instruction::Opc1,
            ::Emulator::Cpu::Instruction::Opc4,
            ::Emulator::Cpu::Instruction::Opc5,
            ::Emulator::Cpu::Instruction::Opc8,
            ::Emulator::Cpu::Instruction::Opc9,
            ::Emulator::Cpu::Instruction::Opcb11,
            ::Emulator::Cpu::Instruction::Opcb7c,
            ::Emulator::Cpu::Instruction::Opcc,
            ::Emulator::Cpu::Instruction::Opcd,
            ::Emulator::Cpu::Instruction::Opd0,
            ::Emulator::Cpu::Instruction::Opd1,
            ::Emulator::Cpu::Instruction::Opd4,
            ::Emulator::Cpu::Instruction::Opd5,
            ::Emulator::Cpu::Instruction::Opd8,
            ::Emulator::Cpu::Instruction::Opdc,
            ::Emulator::Cpu::Instruction::Ope0,
            ::Emulator::Cpu::Instruction::Ope1,
            ::Emulator::Cpu::Instruction::Ope5,
            ::Emulator::Cpu::Instruction::Ope2,
            ::Emulator::Cpu::Instruction::Opea,
            ::Emulator::Cpu::Instruction::Opf0,
            ::Emulator::Cpu::Instruction::Opf1,
            ::Emulator::Cpu::Instruction::Opf5,
            ::Emulator::Cpu::Instruction::Opfe
        ].freeze

        def initialize
          byte_sized_instructions = INSTRUCTIONS.reject {|instruction| instruction.opcode > 0xFF}
          word_sized_instructions = INSTRUCTIONS.reject {|instruction| instruction.opcode <= 0xFF}

          @byte_sized_instructions_table = Array.new(0xFF)
          byte_sized_instructions.each {|instruction| @byte_sized_instructions_table[instruction.opcode] = instruction}

          @word_sized_instructions = Array.new(0xFF)
          word_sized_instructions.each {|instruction| @word_sized_instructions[instruction.opcode & 0xFF] = instruction}
        end

        def [](opcode)
          instruction = opcode <= 0xFF ? @byte_sized_instructions_table[opcode] : @word_sized_instructions[opcode & 0xFF]

          raise NotImplementedError, "MISSING OPCODE: 0x#{opcode.to_s(16).rjust(opcode <= 0xFF ? 2 : 4, '0')}" if instruction.nil?
          instruction
        end
      end
    end
  end
end