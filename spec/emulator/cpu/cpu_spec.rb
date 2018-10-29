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
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x01},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x11},
        {register: :hl, high_register: :h, low_register: :l, instruction: 0x21}
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
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x02},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x12}
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

    context "LD A,(HL+)" do
      it 'should execute instruction' do
        mmu[0x00] = 0x2A
        mmu[0xAABB] = 0xCC
        state.hl.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBC, a: 0xCC)
      end
    end

    context "LD A,(HL-)" do
      it 'should execute instruction' do
        mmu[0x00] = 0x3A
        mmu[0xAABB] = 0xCC
        state.hl.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBA, a: 0xCC)
      end
    end

    context "LD (a16),A" do
      it 'should execute instruction' do
        mmu[0x00] = 0xEA
        mmu[0x01] = 0xCC
        mmu[0x02] = 0xEE

        state.a.write_value(0xAA)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x03, a: 0xAA)
        expect(mmu[0xEECC]).to eq(0xAA)
      end
    end

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x03},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x13},
        {register: :hl, high_register: :h, low_register: :l, instruction: 0x23},
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

    context 'INC SP' do
      it 'should execute instruction' do
        mmu[0x00] = 0x33

        state.sp.write_value(0xAAFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, :sp => 0xAB00)
      end
    end

    [
        {register: :b, instruction: 0x04},
        {register: :c, instruction: 0x0C},
        {register: :d, instruction: 0x14},
        {register: :e, instruction: 0x1C},
        {register: :h, instruction: 0x24},
        {register: :l, instruction: 0x2C},
        {register: :a, instruction: 0x3C}
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "INC #{register.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0000)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0000_0000)
        end

        it 'should disable zero flag when result is not zero' do
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

    context "INC (HL)" do
      it 'should execute instruction' do
        mmu[0x00] = 0x34
        mmu[0x1122] = 0xBB

        state.hl.write_value(0x1122)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0x11, l: 0x22)
        expect(mmu[0x1122]).to eq(0xBC)
      end

      it 'should disable zero flag when result is not zero' do
        mmu[0x00] = 0x34
        mmu[0x1122] = 0b0000_0000

        state.hl.write_value(0x1122)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0x11, l: 0x22, f: 0b0000_0000)
        expect(mmu[0x1122]).to eq(0b0000_0001)
      end

      it 'should disable subtract flag' do
        mmu[0x00] = 0x34
        mmu[0x1122] = 0b0000_0000

        state.hl.write_value(0x1122)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0x11, l: 0x22, f: 0b0000_0000)
        expect(mmu[0x1122]).to eq(0b0000_0001)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x34
        mmu[0x1122] = 0b0000_1111

        state.hl.write_value(0x1122)
        state.f.toggle_half_carry_flag(false)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0x11, l: 0x22, f: 0b0010_0000)
        expect(mmu[0x1122]).to eq(0b0001_0000)
      end
    end

    [
        {register: :b, instruction: 0x05},
        {register: :c, instruction: 0x0D},
        {register: :d, instruction: 0x15},
        {register: :e, instruction: 0x1D},
        {register: :l, instruction: 0x2D},
        {register: :a, instruction: 0x3D},
        {register: :h, instruction: 0x25}
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

        it 'should disable zero flag when result is not zero' do
          mmu[0x00] = instruction

          state.send(register).write_value(0b0000_0010)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{register}" => 0b0000_0001, f: 0b0100_0000)
        end

        it 'should enable zero flag when result is zero' do
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

    context "DEC (HL)" do
      it 'should execute instruction' do
        mmu[0x00] = 0x35
        mmu[0xAABB] = 0b0000_1000

        state.hl.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBB, f: 0b0100_0000)
        expect(mmu[0xAABB]).to eq(0b0000_0111)
      end

      it 'should disable zero flag when result is not zero' do
        mmu[0x00] = 0x35
        mmu[0xAABB] = 0b0000_0010

        state.hl.write_value(0xAABB)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBB, f: 0b0100_0000)
        expect(mmu[0xAABB]).to eq(0b0000_0001)
      end

      it 'should enable zero flag when result is zero' do
        mmu[0x00] = 0x35
        mmu[0xAABB] = 0b0000_0001

        state.hl.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBB, f: 0b1100_0000)
        expect(mmu[0xAABB]).to eq(0b0000_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x35
        mmu[0xAABB] = 0b0001_0000

        state.hl.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xAA, l: 0xBB, f: 0b0110_0000)
        expect(mmu[0xAABB]).to eq(0b0000_1111)
      end
    end

    [
        {register: :b, instruction: 0x06},
        {register: :c, instruction: 0x0E},
        {register: :d, instruction: 0x16},
        {register: :e, instruction: 0x1E},
        {register: :l, instruction: 0x2E},
        {register: :a, instruction: 0x3E},
        {register: :h, instruction: 0x26},
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

    context "LD (HL),d8" do
      it 'should execute instruction' do
        mmu[0x00] = 0x36
        mmu[0x01] = 0xCC
        mmu[0xAABB] = 0xDD

        state.hl.write_value(0xAABB)

        subject.tick
        expect(state).to match_cpu_state(pc: 0x2, h: 0xAA, l: 0xBB)
        expect(mmu[0xAABB]).to eq(0xCC)
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
        state.a.write_value(0b0000_0000)

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
        {primary_register: :hl, secondary_register: :bc, primary_high_register: :h, primary_low_register: :l, secondary_high_register: :b, secondary_low_register: :c, instruction: 0x09},
        {primary_register: :hl, secondary_register: :de, primary_high_register: :h, primary_low_register: :l, secondary_high_register: :d, secondary_low_register: :e, instruction: 0x19},
    ].each do |options|
      primary_register = options[:primary_register]
      secondary_register = options[:secondary_register]
      primary_high_register = options[:primary_high_register]
      primary_low_register = options[:primary_low_register]
      secondary_high_register = options[:secondary_high_register]
      secondary_low_register = options[:secondary_low_register]
      instruction = options[:instruction]

      context "ADD #{primary_register.to_s.upcase},#{secondary_register.to_s.upcase}" do
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

    context "ADD HL,HL" do
      it 'should execute instruction' do
        mmu[0x00] = 0x29

        state.hl.write_value 0x0102

        subject.tick

        0x0204
        expect(state).to match_cpu_state(pc: 0x1, h: 0x02, l: 0x04)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x29

        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, f: 0b0000_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x29

        state.hl.write_value 0x0FFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0x1F, l: 0xFE, f: 0b0010_0000)
      end

      it 'should set carry flag' do
        mmu[0x00] = 0x29

        state.hl.write_value 0xFFFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, h: 0xFF, l: 0xFE, f: 0b0011_0000)
      end
    end

    context "ADD HL,SP" do
      it 'should execute instruction' do
        mmu[0x00] = 0x39

        state.hl.write_value 0x0102
        state.sp.write_value 0x0304

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, sp: 0x0304, h: 0x04, l: 0x06)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x39

        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, f: 0b0000_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x39

        state.hl.write_value 0x0FFF
        state.sp.write_value 0x0FFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, sp: 0x0FFF, h: 0x1F, l: 0xFE, f: 0b0010_0000)
      end

      it 'should set carry flag' do
        mmu[0x00] = 0x39

        state.hl.write_value 0xFFFF
        state.sp.write_value 0xFFFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, sp: 0xFFFF, h: 0xFF, l: 0xFE, f: 0b0011_0000)
      end
    end

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x0A},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x1A},
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "LD A,(#{register.upcase})" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xAABB)

          mmu[0xAABB] = 0xDD

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{high_register}" => 0xAA, :"#{low_register}" => 0xBB, a: 0xDD)
        end
      end
    end

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x0B},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x1B},
        {register: :hl, high_register: :h, low_register: :l, instruction: 0x2B}
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "DEC #{register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xAABB)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, :"#{high_register}" => 0xAA, :"#{low_register}" => 0xBA)
        end
      end
    end

    context "DEC SP" do
      it 'should execute instruction' do
        mmu[0x00] = 0x3B

        state.sp.write_value(0xAABB)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, sp: 0xAABA)
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
        state.a.write_value(0b0000_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0000_0000)
      end
    end

    context 'RRA' do
      it 'should execute instruction' do
        mmu[0x00] = 0x1F
        state.f.toggle_carry_flag(true)
        state.a.write_value(0b0110_0010)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b1011_0001, f: 0b0000_0000)
      end

      it 'should reset zero flag' do
        mmu[0x00] = 0x1F
        state.a.write_value(0)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x1F
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x1F
        state.a.write_value(0)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should reset half carry flag' do
        mmu[0x00] = 0x1F
        state.a.write_value(0)
        state.f.toggle_half_carry_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0, f: 0b0000_0000)
      end

      it 'should carry flag be 1 when bit rotated is 1' do
        mmu[0x00] = 0x1F
        state.a.write_value(0b0000_0001)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, a: 0b0000_0000, f: 0b0001_0000)
      end

      it 'should carry flag be 0 when bit rotated is 0' do
        mmu[0x00] = 0x1F
        state.a.write_value(0b0000_0000)

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

    context 'JR Z,r8' do
      context 'when zero flag is set' do
        it 'should jump to offset' do
          mmu[0x00] = 0x28
          mmu[0x01] = 0b000_0010

          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0100, f: 0b1000_0000)
        end

        it 'should decrement when offset is negative' do
          state.pc.write_value(0x02)

          mmu[0x02] = 0x28
          mmu[0x03] = 0b1111_1111

          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0011, f: 0b1000_0000)
        end
      end

      context 'when zero flag is reset' do
        it 'should not jump to offset' do
          mmu[0x00] = 0x28
          mmu[0x01] = 0b000_0010

          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0010)
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

    context 'JR C,r8' do
      context 'when zero flag is set' do
        it 'should jump to offset' do
          mmu[0x00] = 0x38
          mmu[0x01] = 0b000_0010

          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0100, f: 0b0001_0000)
        end

        it 'should decrement when offset is negative' do
          state.pc.write_value(0x02)

          mmu[0x02] = 0x38
          mmu[0x03] = 0b1111_1111

          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0011, f: 0b0001_0000)
        end
      end

      context 'when zero flag is reset' do
        it 'should not jump to offset' do
          mmu[0x00] = 0x38
          mmu[0x01] = 0b000_0010

          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0b000_0010)
        end
      end
    end

    [
        {source_register: :b, target_register: :b, instruction: 0x40},
        {source_register: :c, target_register: :b, instruction: 0x41},
        {source_register: :d, target_register: :b, instruction: 0x42},
        {source_register: :e, target_register: :b, instruction: 0x43},
        {source_register: :h, target_register: :b, instruction: 0x44},
        {source_register: :l, target_register: :b, instruction: 0x45},
        {source_register: :a, target_register: :b, instruction: 0x47},
        {source_register: :b, target_register: :c, instruction: 0x48},
        {source_register: :c, target_register: :c, instruction: 0x49},
        {source_register: :d, target_register: :c, instruction: 0x4A},
        {source_register: :e, target_register: :c, instruction: 0x4B},
        {source_register: :h, target_register: :c, instruction: 0x4C},
        {source_register: :l, target_register: :c, instruction: 0x4D},
        {source_register: :a, target_register: :c, instruction: 0x4F},
        {source_register: :b, target_register: :d, instruction: 0x50},
        {source_register: :c, target_register: :d, instruction: 0x51},
        {source_register: :d, target_register: :d, instruction: 0x52},
        {source_register: :e, target_register: :d, instruction: 0x53},
        {source_register: :h, target_register: :d, instruction: 0x54},
        {source_register: :l, target_register: :d, instruction: 0x55},
        {source_register: :a, target_register: :d, instruction: 0x57},
        {source_register: :b, target_register: :e, instruction: 0x58},
        {source_register: :c, target_register: :e, instruction: 0x59},
        {source_register: :d, target_register: :e, instruction: 0x5A},
        {source_register: :e, target_register: :e, instruction: 0x5B},
        {source_register: :h, target_register: :e, instruction: 0x5C},
        {source_register: :l, target_register: :e, instruction: 0x5D},
        {source_register: :a, target_register: :e, instruction: 0x5F},
        {source_register: :b, target_register: :h, instruction: 0x60},
        {source_register: :c, target_register: :h, instruction: 0x61},
        {source_register: :d, target_register: :h, instruction: 0x62},
        {source_register: :e, target_register: :h, instruction: 0x63},
        {source_register: :h, target_register: :h, instruction: 0x64},
        {source_register: :l, target_register: :h, instruction: 0x65},
        {source_register: :a, target_register: :h, instruction: 0x67},
        {source_register: :b, target_register: :l, instruction: 0x68},
        {source_register: :c, target_register: :l, instruction: 0x69},
        {source_register: :d, target_register: :l, instruction: 0x6A},
        {source_register: :e, target_register: :l, instruction: 0x6B},
        {source_register: :h, target_register: :l, instruction: 0x6C},
        {source_register: :l, target_register: :l, instruction: 0x6D},
        {source_register: :a, target_register: :l, instruction: 0x6F},
        {source_register: :b, target_register: :a, instruction: 0x78},
        {source_register: :c, target_register: :a, instruction: 0x79},
        {source_register: :d, target_register: :a, instruction: 0x7A},
        {source_register: :e, target_register: :a, instruction: 0x7B},
        {source_register: :h, target_register: :a, instruction: 0x7C},
        {source_register: :l, target_register: :a, instruction: 0x7D},
        {source_register: :a, target_register: :a, instruction: 0x7F}
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

    [
        {register: :b, instruction: 0x46},
        {register: :c, instruction: 0x4e},
        {register: :d, instruction: 0x56},
        {register: :e, instruction: 0x5e},
        {register: :h, instruction: 0x66},
        {register: :l, instruction: 0x6e},
        {register: :a, instruction: 0x7e},

    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "LD #{register.to_s.upcase},(HL)" do
        it 'should execute instruction' do
          mmu[0x00] = instruction
          mmu[0xAA11] = 0xEF
          state.hl.write_value(0xAA11)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, h: 0xAA, l: 0x11, :"#{register}" => 0xEF)
        end
      end
    end

    [
        {register: :b, instruction: 0x70},
        {register: :c, instruction: 0x71},
        {register: :d, instruction: 0x72},
        {register: :e, instruction: 0x73},
        {register: :a, instruction: 0x77}

    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "LD (HL),#{register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xEF)
          state.hl.write_value(0xAA11)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, h: 0xAA, l: 0x11, :"#{register}" => 0xEF)
          expect(mmu[0xAA11]).to eq(0xEF)
        end
      end
    end

    context 'LD (HL),H' do
      it 'should execute instruction' do
        mmu[0x00] = 0x74

        state.hl.write_value(0xAA11)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, h: 0xAA, l: 0x11)
        expect(mmu[0xAA11]).to eq(0xAA)
      end
    end

    context 'LD (HL),H' do
      it 'should execute instruction' do
        mmu[0x00] = 0x75

        state.hl.write_value(0xAA11)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, h: 0xAA, l: 0x11)
        expect(mmu[0xAA11]).to eq(0x11)
      end
    end

    context 'LDH A,(a8)' do
      it 'should execute instruction' do
        mmu[0x00] = 0xF0
        mmu[0x01] = 0xCC
        mmu[0xFFCC] = 0xBB

        subject.tick

        expect(state).to match_cpu_state(pc: 0x02, a: 0xBB)
        expect(mmu[0xFFCC]).to eq(0xBB)
      end
    end

    context 'CPL' do
      it 'should execute instruction' do
        mmu[0x00] = 0x2F
        state.a.write_value(0b1111_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, a: 0b0000_1111, f: 0b0110_0000)
      end
    end

    context 'SCF' do
      it 'should execute instruction' do
        mmu[0x00] = 0x37
        state.f.toggle_carry_flag(false)
        state.f.toggle_half_carry_flag(true)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, f: 0b0001_0000)
      end
    end

    context 'CCF' do
      it 'should reset carry flag if set' do
        mmu[0x00] = 0x3F
        state.f.toggle_carry_flag(true)
        state.f.toggle_half_carry_flag(true)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, f: 0b0000_0000)
      end

      it 'should set carry flag if reset' do
        mmu[0x00] = 0x3F
        state.f.toggle_carry_flag(false)
        state.f.toggle_half_carry_flag(true)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, f: 0b0001_0000)
      end
    end

    [
        {register: :b, instruction: 0xA8},
        {register: :c, instruction: 0xA9},
        {register: :d, instruction: 0xAA},
        {register: :e, instruction: 0xAB},
        {register: :h, instruction: 0xAC},
        {register: :l, instruction: 0xAD},
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]

      context "XOR #{register}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.a.write_value(0b0100_1000)
          state.send(register).write_value(0b1011_0011)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, a: 0b1111_1011, :"#{register}" => 0b1011_0011)
        end

        it 'should reset subtract flag' do
          mmu[0x00] = instruction

          state.a.write_value(0b0100_1000)
          state.send(register).write_value(0b1011_0011)
          state.f.toggle_subtract_flag(true)

          subject.tick

          expect(state.f.read_value).to eq(0x0)
        end

        it 'should reset half carry flag' do
          mmu[0x00] = instruction

          state.a.write_value(0b0100_1000)
          state.send(register).write_value(0b1011_0011)
          state.f.toggle_half_carry_flag(true)

          subject.tick

          expect(state.f.read_value).to eq(0x0)
        end

        it 'should reset carry flag' do
          mmu[0x00] = instruction

          state.a.write_value(0b0100_1000)
          state.send(register).write_value(0b1011_0011)
          state.f.toggle_half_carry_flag(true)

          subject.tick

          expect(state.f.read_value).to eq(0x0)
        end

        it 'should reset zero flag when result is not zero' do
          mmu[0x00] = instruction

          state.a.write_value(0b0100_1000)
          state.send(register).write_value(0b1011_0011)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state.f.read_value).to eq(0x0)
        end

        it 'should set zero flag when result is zero' do
          mmu[0x00] = instruction

          state.a.write_value(0b0101_0101)
          state.send(register).write_value(0b0101_0101)
          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state.f.read_value).to eq(0b1000_0000)
        end
      end
    end

    context 'XOR A' do
      it 'should execute instruction' do
        mmu[0x00] = 0xAF

        state.a.write_value(0b0101_0101)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x01, a: 0b0000_0000, f: 0b1000_0000)
      end
    end

    [
        {bit: 7, register: :h, instruction: 0x7C}
    ].each do |options|
      bit = options[:bit]
      register = options[:register]
      instruction = options[:instruction]

      context "BIT #{bit},#{register.to_s.upcase}" do
        it 'should set zero flag when bit is 0' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction

          value = 0b1111_1111 ^ (1 << bit)
          state.send(register).write_value(value)
          state.f.toggle_zero_flag(false)
          state.f.toggle_subtract_flag(true)
          state.f.toggle_half_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x02, :"#{register}" => value, f: 0b1010_0000)
        end

        it 'should reset zero flag when bit is not 0' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction

          value = 0b1111_1111
          state.send(register).write_value(value)
          state.f.toggle_zero_flag(true)
          state.f.toggle_subtract_flag(true)
          state.f.toggle_half_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x02, :"#{register}" => value, f: 0b0010_0000)
        end
      end
    end

    context "LDH (a8),A" do
      it 'should execute instruction' do
        mmu[0x00] = 0xE0
        mmu[0x01] = 0xDA

        state.a.write_value(0xCD)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x2, a: 0xCD)
        expect(mmu[0xFFDA]).to eq(0xCD)
      end
    end

    context "LD (C),A" do
      it 'should execute instruction' do
        mmu[0x00] = 0xE2

        state.c.write_value(0xDD)
        state.a.write_value(0xCD)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x2, a: 0xCD, c: 0xDD)
        expect(mmu[0xFFDD]).to eq(0xCD)
      end
    end

    context 'CALL NZ,a16' do
      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC4
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xAABB, sp: 0xFFFC)
          expect(mmu[0xFFFD]).to eq(0x00)
          expect(mmu[0xFFFC]).to eq(0x03)
        end
      end

      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC4
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x03, sp: 0xFFFE, f: 0b1000_0000)
          expect(mmu[0xFFFD]).to be_nil
          expect(mmu[0xFFFC]).to be_nil
        end
      end
    end

    context 'CALL NC,a16' do
      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD4
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xAABB, sp: 0xFFFC)
          expect(mmu[0xFFFD]).to eq(0x00)
          expect(mmu[0xFFFC]).to eq(0x03)
        end
      end

      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD4
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x03, sp: 0xFFFE, f: 0b0001_0000)
          expect(mmu[0xFFFD]).to be_nil
          expect(mmu[0xFFFC]).to be_nil
        end
      end
    end

    context 'CALL Z,a16' do
      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xCC
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xAABB, sp: 0xFFFC, f: 0b1000_0000)
          expect(mmu[0xFFFD]).to eq(0x00)
          expect(mmu[0xFFFC]).to eq(0x03)
        end
      end

      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xCC
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x03, sp: 0xFFFE)
          expect(mmu[0xFFFD]).to be_nil
          expect(mmu[0xFFFC]).to be_nil
        end
      end
    end

    context 'CALL C,a16' do
      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xDC
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xAABB, sp: 0xFFFC, f: 0b0001_0000)
          expect(mmu[0xFFFD]).to eq(0x00)
          expect(mmu[0xFFFC]).to eq(0x03)
        end
      end

      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xDC
          mmu[0x01] = 0xBB
          mmu[0x02] = 0xAA

          state.sp.write_value(0xFFFE)
          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x03, sp: 0xFFFE)
          expect(mmu[0xFFFD]).to be_nil
          expect(mmu[0xFFFC]).to be_nil
        end
      end
    end

    context 'CALL a16' do
      it 'should execute instruction' do
        mmu[0x00] = 0xCD
        mmu[0x01] = 0xBB
        mmu[0x02] = 0xAA

        state.sp.write_value(0xFFFE)

        subject.tick

        expect(state).to match_cpu_state(pc: 0xAABB, sp: 0xFFFC)
        expect(mmu[0xFFFD]).to eq(0x00)
        expect(mmu[0xFFFC]).to eq(0x03)
      end
    end

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0xC5},
        {register: :de, high_register: :d, low_register: :e, instruction: 0xD5},
        {register: :hl, high_register: :h, low_register: :l, instruction: 0xE5},
        {register: :af, high_register: :a, low_register: :f, instruction: 0xF5},
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]

      context "PUSH #{register.to_s.upcase}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction

          state.send(register).write_value(0xEEAB)
          state.sp.write_value(0xFFFE)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, :"#{high_register}" => 0xEE, :"#{low_register}" => 0xAB, sp: 0xFFFC)
          expect(mmu[0xFFFD]).to eq(0xEE)
          expect(mmu[0xFFFC]).to eq(0xAB)
        end
      end
    end


    [
        {register: :c, instruction: 0x11},
    ].each do |options|
      register = options[:register]
      instruction = options[:instruction]
      context "RL #{register}" do
        it 'should execute instruction' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.f.toggle_carry_flag(true)
          state.send(register).write_value(0b0110_0010)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b1100_0101, f: 0b0000_0000)
        end

        it 'should set zero flag when result is zero' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0)
          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0, f: 0b1000_0000)
        end

        it 'should reset zero flag when result is not zero' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b0000_0001)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_0010, f: 0b0000_0000)
        end

        it 'should reset subtract flag' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b0000_0001)
          state.f.toggle_subtract_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_0010, f: 0b0000_0000)
        end

        it 'should reset subtract flag' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b0000_0001)
          state.f.toggle_subtract_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_0010, f: 0b0000_0000)
        end

        it 'should reset half carry flag' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b0000_0001)
          state.f.toggle_half_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_0010, f: 0b0000_0000)
        end

        it 'should carry flag be 1 when bit rotated is 1' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b1000_0100)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_1000, f: 0b0001_0000)
        end

        it 'should carry flag be 0 when bit rotated is 0' do
          mmu[0x00] = 0xCB
          mmu[0x01] = instruction
          state.send(register).write_value(0b0000_0010)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x2, :"#{register}" => 0b0000_0100, f: 0b0000_0000)
        end
      end
    end

    context 'RET NZ' do
      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC0

          mmu[0xFFFC] = 0xDD
          mmu[0xFFFD] = 0xEE

          state.sp.write_value(0xFFFC)
          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xEEDD, sp: 0xFFFE)
        end
      end

      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC0

          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, f: 0b1000_0000)
        end
      end
    end

    context 'RET NC' do
      context 'when carry flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD0

          mmu[0xFFFC] = 0xDD
          mmu[0xFFFD] = 0xEE

          state.sp.write_value(0xFFFC)
          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xEEDD, sp: 0xFFFE)
        end
      end

      context 'when carry flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD0

          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1, f: 0b0001_0000)
        end
      end
    end

    context 'RET Z' do
      context 'when zero flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC8

          mmu[0xFFFC] = 0xDD
          mmu[0xFFFD] = 0xEE

          state.sp.write_value(0xFFFC)
          state.f.toggle_zero_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xEEDD, sp: 0xFFFE, f: 0b1000_0000)
        end
      end

      context 'when zero flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xC8

          state.f.toggle_zero_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1)
        end
      end
    end

    context 'RET C' do
      context 'when carry flag is set' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD8

          mmu[0xFFFC] = 0xDD
          mmu[0xFFFD] = 0xEE

          state.sp.write_value(0xFFFC)
          state.f.toggle_carry_flag(true)

          subject.tick

          expect(state).to match_cpu_state(pc: 0xEEDD, sp: 0xFFFE, f: 0b0001_0000)
        end
      end

      context 'when carry flag is reset' do
        it 'should execute instruction' do
          mmu[0x00] = 0xD8

          state.f.toggle_carry_flag(false)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x1)
        end
      end
    end

    context 'RET' do
      it 'should execute instruction' do
        mmu[0x00] = 0xC9

        mmu[0xFFFC] = 0xDD
        mmu[0xFFFD] = 0xEE

        state.sp.write_value(0xFFFC)

        subject.tick

        expect(state).to match_cpu_state(pc: 0xEEDD, sp: 0xFFFE)
      end
    end

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0xC1},
        {register: :de, high_register: :d, low_register: :e, instruction: 0xD1},
        {register: :hl, high_register: :h, low_register: :l, instruction: 0xE1},
        {register: :af, high_register: :a, low_register: :f, instruction: 0xF1}
    ].each do |options|
      register = options[:register]
      high_register = options[:high_register]
      low_register = options[:low_register]
      instruction = options[:instruction]
      context "POP #{register}" do
        it 'should execute instruction' do
          mmu[0x00] = instruction
          mmu[0xFFFC] = 0xDD
          mmu[0xFFFD] = 0xEE

          state.sp.write_value(0xFFFC)

          subject.tick

          expect(state).to match_cpu_state(pc: 0x01, sp: 0xFFFE, :"#{high_register}" => 0xEE, :"#{low_register}" => 0xDD)
        end
      end
    end

    context 'CP d8' do
      it 'should execute instruction' do
        mmu[0x00] = 0xFE
        mmu[0x01] = 0x0A

        state.a.write_value(0x0B)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x02, a: 0x0B, f: 0b0100_0000)
      end

      it 'should set zero flag when result is zero' do
        mmu[0x00] = 0xFE
        mmu[0x01] = 0x0B

        state.a.write_value(0x0B)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x02, a: 0x0B, f: 0b1100_0000)
      end

      it 'should set carry flag when borrowing' do
        mmu[0x00] = 0xFE
        mmu[0x01] = 0b0010_0000

        state.a.write_value(0b0000_1000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x02, a: 0b0000_1000, f: 0b0101_0000)
      end

      it 'should set half carry flag when borrowing from bit 4' do
        mmu[0x00] = 0xFE
        mmu[0x01] = 0b0000_0100

        state.a.write_value(0b0001_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x02, a: 0b0001_0000, f: 0b0110_0000)
      end
    end
  end
end