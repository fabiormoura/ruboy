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
        {register: :de, high_register: :d, low_register: :e, instruction: 0x11}
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

    [
        {register: :bc, high_register: :b, low_register: :c, instruction: 0x03},
        {register: :de, high_register: :d, low_register: :e, instruction: 0x13},
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

    [
        {register: :b, instruction: 0x04},
        {register: :c, instruction: 0x0C},
        {register: :d, instruction: 0x14}
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
        {register: :b, instruction: 0x05},
        {register: :c, instruction: 0x0D},
        {register: :d, instruction: 0x15},
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

    context 'LD B,d8' do
      it 'should execute instruction' do
        mmu[0x00] = 0x06
        mmu[0x01] = 0xCC

        subject.tick

        expect(state).to match_cpu_state(pc: 0x2, b: 0xCC)
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

    context 'ADD HL,BC' do
      it 'should execute instruction' do
        mmu[0x00] = 0x09

        state.hl.write_value 0x0102
        state.bc.write_value 0x0304

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0x03, c: 0x04, h: 0x04, l: 0x06)
      end

      it 'should reset subtract flag' do
        mmu[0x00] = 0x09

        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, f: 0b0000_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x09

        state.hl.write_value 0x0FFF
        state.bc.write_value 0x0FFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0x0F, c: 0xFF, l: 0xFE, h: 0x1F, f: 0b0010_0000)
      end

      it 'should set carry flag' do
        mmu[0x00] = 0x09

        state.hl.write_value 0xFFFF
        state.bc.write_value 0xFFFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xFF, c: 0xFF, l: 0xFE, h: 0xFF, f: 0b0011_0000)
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

    [
        {register: :c, instruction: 0x0E}
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
  end
end