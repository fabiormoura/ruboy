require_relative '../../spec_helper'

RSpec.describe Emulator::Cpu::Cpu do
  let(:mmu) {Emulator::MmuStub.new}
  let(:state) {Emulator::Cpu::State.new}

  subject {described_class.new(mmu: mmu, state: state)}

  context 'instructions' do
    context 'NOP' do
      it 'should execute instruction' do
        mmu[0x00] = 0x00
        subject.tick
        expect(state).to match_cpu_state(pc: 0x1)
      end
    end

    [
      { register: :bc, high_register: :b, low_register: :c, instruction: 0x01 },
      { register: :de, high_register: :d, low_register: :e, instruction: 0x11 },
      { register: :hl, high_register: :h, low_register: :l, instruction: 0x21 }
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "LD #{register.to_s.upcase},d16" do
        it 'should execute instruction' do
          mmu[0x00] = instruction
          mmu[0x01] = 0xAB
          mmu[0x02] = 0xCD
          subject.tick
          expect(state).to match_cpu_state(pc: 0x3, :"#{high_register}" => 0xCD, :"#{low_register}" => 0xAB)
        end
      end
    end

    context "LD SP,d16" do
      it 'should execute instruction' do
        mmu[0x00] = 0x31
        mmu[0x01] = 0xAB
        mmu[0x02] = 0xCD
        subject.tick
        expect(state).to match_cpu_state(pc: 0x3, :sp => 0xCDAB)
      end
    end


    [
      { register: :bc, high_register: :b, low_register: :c, instruction: 0x02 },
      { register: :de, high_register: :d, low_register: :e, instruction: 0x12 }
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "LD (#{register.to_s.upcase}),A" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xAABB)
          state.a.write_value(0xFF)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{high_register}" => 0xAA, :"#{low_register}" => 0xBB, a: 0xFF)
          expect(mmu[0xAABB]).to eq(0xFF)
        end
      end
    end

    context "LD (HL+),A" do
      it 'should execute instruction' do
        mmu[0x00] = 0x22

        state.hl.write_value(0xAABB)
        state.a.write_value(0xFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBC, a: 0xFF)
        expect(mmu[0xAABB]).to eq(0xFF)
      end
    end

    context "LD (HL-),A" do
      it 'should execute instruction' do
        mmu[0x00] = 0x32

        state.hl.write_value(0xAABB)
        state.a.write_value(0xFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBA, a: 0xFF)
        expect(mmu[0xAABB]).to eq(0xFF)
      end
    end

    [
      { register: :bc, high_register: :b, low_register: :c, instruction: 0x03 },
      { register: :de, high_register: :d, low_register: :e, instruction: 0x13 },
      { register: :hl, high_register: :h, low_register: :l, instruction: 0x23 },
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "INC #{register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xAAFF)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{high_register}" => 0xAB, :"#{low_register}" => 0x00)
        end
      end
    end

    context "INC SP" do
      it 'should execute instruction' do
        mmu[0x00] = 0x33

        state.sp.write_value(0xAAFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, :sp => 0xAB00)
      end
    end

    [
      { register: :b, instruction: 0x04 },
      { register: :c, instruction: 0x0C },
      { register: :d, instruction: 0x14 },
      { register: :e, instruction: 0x1C }
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "INC #{register.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0000)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0000_000)
        end

        it 'should disable zero flag if result is not zero' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0000)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0000_0000)
        end

        it 'should disable subtract flag' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0000)
          state.f.toggle_subtract_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0000_0000)
        end

        it 'should set half carry flag' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_1111)
          state.f.toggle_half_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0001_0000, f: 0b0010_0000)
        end
      end
    end

    [
      { register: :b, instruction: 0x05 },
      { register: :c, instruction: 0x0D },
      { register: :d, instruction: 0x15 },
      { register: :e, instruction: 0x1D },
      { register: :l, instruction: 0x2D },
      { register: :a, instruction: 0x3D }
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "DEC #{register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_1000)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0111, f: 0b0100_0000)
        end

        it 'should disable zero flag if result is not zero' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0010)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0100_0000)
        end

        it 'should enable zero flag if result is zero' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0001)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0000, f: 0b1100_0000)
        end

        it 'should set half carry flag' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0001_0000)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_1111, f: 0b0110_0000)
        end
      end
    end

    [
      { register: :b, instruction: 0x06 },
      { register: :c, instruction: 0x0E },
      { register: :d, instruction: 0x16 },
      { register: :e, instruction: 0x1E },
      { register: :l, instruction: 0x2E },
      { register: :a, instruction: 0x3E }
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "LD #{register.to_s.upcase},d8" do
        it 'should execute instruction' do
          mmu[0x00] = instruction
          mmu[0x01] = 0xAB
          subject.tick
          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0xAB)
        end
      end
    end

    context 'RLCA' do
      it 'should execute instruction' do
        mmu[0x00] = 0x07
        state.a.write_value(0b0110_0010)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b1100_0100)
      end

      it 'should reset zero flag' do
        mmu[0x00] = 0x07
        state.a.write_value(0)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x07
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x07
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset half carry flag' do
        mmu[0x00] = 0x07
        state.a.write_value(0)
        state.f.toggle_half_carry_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should carry flag be 1 when bit rotated is 1' do
        mmu[0x00] = 0x07
        state.a.write_value(0b1000_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0001, f: 0b0001_0000)
      end

      it 'should carry flag be 0 when bit rotated is 0' do
        mmu[0x00] = 0x07
        state.a.write_value(0b0000_000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0000_0000)
      end
    end

    context 'LD (a16),SP' do
      it 'should execute instruction' do
        mmu[0x00] = 0x08
        mmu[0x01] = 0xAB
        mmu[0x02] = 0xCD

        state.sp.write_value(0xBBAA)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x3, sp: 0xBBAA)
        expect(mmu[0xCDAB]).to eq(0xAA)
        expect(mmu[0xCDAB + 1]).to eq(0xBB)
      end
    end


    [
      { primary_register: :hl, secondary_register: :bc, primary_high_register: :h, primary_low_register: :l, secondary_high_register: :b, secondary_low_register: :c, instruction: 0x09 },
      { primary_register: :hl, secondary_register: :de, primary_high_register: :h, primary_low_register: :l, secondary_high_register: :d, secondary_low_register: :e, instruction: 0x19 },
    ].each do |options|
      primary_register = options[:primary_register]
      secondary_register = options[:secondary_register]
      primary_high_register = options[:primary_high_register]
      primary_low_register = options[:primary_low_register]
      secondary_high_register = options[:secondary_high_register]
      secondary_low_register = options[:secondary_low_register]
      instruction = options[:instruction]

      context "ADD #{primary_low_register.to_s.upcase},#{secondary_low_register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(primary_register).write_value 0x0102
          state.send(secondary_register).write_value 0x0304

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{secondary_high_register}" => 0x03, :"#{secondary_low_register}" => 0x04, :"#{primary_high_register}" => 0x04, :"#{primary_low_register}" => 0x06)
        end

        it 'should reset subtract flag' do
          mmu[0x00] = instruction

          state.f.toggle_subtract_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, f: 0b0000_0000)
        end

        it 'should set half carry flag' do
          mmu[0x00] = instruction

          state.send(primary_register).write_value 0x0FFF
          state.send(secondary_register).write_value 0x0FFF

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{secondary_high_register}" => 0x0F, :"#{secondary_low_register}" => 0xFF, :"#{primary_high_register}" => 0x1F, :"#{primary_low_register}" => 0xFE, f: 0b0010_0000)
        end

        it 'should set carry flag' do
          mmu[0x00] = instruction

          state.send(primary_register).write_value 0xFFFF
          state.send(secondary_register).write_value 0xFFFF

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{secondary_high_register}" => 0xFF, :"#{secondary_low_register}" => 0xFF, :"#{primary_high_register}" => 0xFF, :"#{primary_low_register}" => 0xFE, f: 0b0011_0000)
        end
      end
    end

    context 'LD A,(BC)' do
      it 'should execute instruction' do
        mmu[0x00] = 0x0A

        state.bc.write_value(0xAABB)

        mmu[0xAABB] = 0xDD

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xAA, c: 0xBB, a: 0xDD)
      end
    end

    context 'DEC BC' do
      it 'should execute instruction' do
        mmu[0x00] = 0x0B

        state.bc.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xAA, c: 0xBA)
      end
    end

    context 'RRCA' do
      it 'should execute instruction' do
        mmu[0x00] = 0x0F
        state.a.write_value(0b0110_0010)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0011_0001)
      end

      it 'should reset zero flag' do
        mmu[0x00] = 0x0F
        state.a.write_value(0)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x0F
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x0F
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset half carry flag' do
        mmu[0x00] = 0x0F
        state.a.write_value(0)
        state.f.toggle_half_carry_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should carry flag be 1 when bit rotated is 1' do
        mmu[0x00] = 0x0F
        state.a.write_value(0b0000_0001)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b1000_0000, f: 0b0001_0000)
      end

      it 'should carry flag be 0 when bit rotated is 0' do
        mmu[0x00] = 0x0F
        state.a.write_value(0b0000_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0000_0000)
      end
    end

    context 'RLA' do
      it 'should execute instruction' do
        mmu[0x00] = 0x17
        state.f.toggle_carry_flag(true)
        state.a.write_value(0b0110_0010)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b1100_0101, f: 0b0000_0000)
      end

      it 'should reset zero flag' do
        mmu[0x00] = 0x17
        state.a.write_value(0)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x17
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x17
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset half carry flag' do
        mmu[0x00] = 0x17
        state.a.write_value(0)
        state.f.toggle_half_carry_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should carry flag be 1 when bit rotated is 1' do
        mmu[0x00] = 0x17
        state.a.write_value(0b1000_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0001_0000)
      end

      it 'should carry flag be 0 when bit rotated is 0' do
        mmu[0x00] = 0x17
        state.a.write_value(0b0000_000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0000_0000)
      end
    end

    context 'JR r8' do
      it 'should increment when offset is positive' do
        mmu[0x00] = 0x18
        mmu[0x01] = 0b000_0010

        subject.tick

        expect(state).to match_cpu_state(pc: 0b000_0100)
      end

      it 'should decrement when offset is negative' do
        state.pc.write_value(0x02)

        mmu[0x02] = 0x18
        mmu[0x03] = 0b1111_1111

        subject.tick

        expect(state).to match_cpu_state(pc: 0b000_0011)
      end
    end

    context 'JR NZ,r8' do
      context 'when zero flag is reset' do
        it 'should jump to offset' do
          mmu[0x00] = 0x20
          mmu[0x01] = 0b000_0010

          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0100)
        end

        it 'should decrement when offset is negative' do
          state.pc.write_value(0x02)

          mmu[0x02] = 0x20
          mmu[0x03] = 0b1111_1111

          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0011)
        end
      end

      context 'when zero flag is set' do
        it 'should not jump to offset' do
          mmu[0x00] = 0x20
          mmu[0x01] = 0b000_0010

          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0010, f: 0b1000_0000)
        end
      end
    end

    context 'JR NC,r8' do
      context 'when zero flag is reset' do
        it 'should jump to offset' do
          mmu[0x00] = 0x30
          mmu[0x01] = 0b000_0010

          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0100)
        end

        it 'should decrement when offset is negative' do
          state.pc.write_value(0x02)

          mmu[0x02] = 0x30
          mmu[0x03] = 0b1111_1111

          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0011)
        end
      end

      context 'when zero flag is set' do
        it 'should not jump to offset' do
          mmu[0x00] = 0x30
          mmu[0x01] = 0b000_0010

          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0010, f: 0b0001_0000)
        end
      end
    end

    [
      { source_register: :b, target_register: :b, instruction: 0x40 },
      { source_register: :c, target_register: :b, instruction: 0x41 },
      { source_register: :d, target_register: :b, instruction: 0x42 },
      { source_register: :e, target_register: :b, instruction: 0x43 },
      { source_register: :h, target_register: :b, instruction: 0x44 },
      { source_register: :l, target_register: :b, instruction: 0x45 },
      { source_register: :a, target_register: :b, instruction: 0x47 },
      { source_register: :b, target_register: :c, instruction: 0x48 },
      { source_register: :c, target_register: :c, instruction: 0x49 },
      { source_register: :d, target_register: :c, instruction: 0x4A },
      { source_register: :e, target_register: :c, instruction: 0x4B },
      { source_register: :h, target_register: :c, instruction: 0x4C },
      { source_register: :l, target_register: :c, instruction: 0x4D },
      { source_register: :a, target_register: :c, instruction: 0x4F }
    ].each do |options|
      source_register = options[:source_register]
      target_register = options[:target_register]
      instruction = options[:instruction]

      context "LD #{target_register.to_s.upcase},#{source_register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(source_register).write_value(0x11)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, :"#{source_register}" => 0x11, :"#{target_register}" => 0x11)
        end

      end
    end
  end
end