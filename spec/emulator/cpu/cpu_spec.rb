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

    context 'LD BC,d16' do
      it 'should execute instruction' do
        mmu[0x00] = 0x01
        mmu[0x01] = 0xAB
        mmu[0x02] = 0xCD
        subject.tick
        expect(state).to match_cpu_state(pc: 0x3, b: 0xCD, c: 0xAB)
      end
    end

    context 'LD BC,A' do
      it 'should execute instruction' do
        mmu[0x00] = 0x02

        state.b.write_value(0xAA)
        state.c.write_value(0xBB)
        state.a.write_value(0xFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xAA, c: 0xBB, a: 0xFF)
        expect(mmu[0xAABB]).to eq(0xFF)
      end
    end

    context 'INC BC' do
      it 'should execute instruction' do
        mmu[0x00] = 0x03

        state.b.write_value(0xAA)
        state.c.write_value(0xFF)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xAB, c: 0x00)
      end
    end

    context 'INC B' do
      it 'should execute instruction' do
        mmu[0x00] = 0x04

        state.b.write_value(0b0000_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0001, f: 0b0000_000)
      end

      it 'should disable zero flag if result is not zero' do
        mmu[0x00] = 0x04

        state.b.write_value(0b0000_0000)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0001, f: 0b0000_0000)
      end

      it 'should disable subtract flag' do
        mmu[0x00] = 0x04

        state.b.write_value(0b0000_0000)
        state.f.toggle_subtract_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0001, f: 0b0000_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x04

        state.b.write_value(0b0000_1111)
        state.f.toggle_half_carry_flag(false)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0001_0000, f: 0b0010_0000)
      end
    end

    context 'DEC B' do
      it 'should execute instruction' do
        mmu[0x00] = 0x05

        state.b.write_value(0b0000_1000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0111, f: 0b0100_0000)
      end

      it 'should disable zero flag if result is not zero' do
        mmu[0x00] = 0x05

        state.b.write_value(0b0000_0010)
        state.f.toggle_zero_flag(true)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0001, f: 0b0100_0000)
      end

      it 'should enable zero flag if result is zero' do
        mmu[0x00] = 0x05

        state.b.write_value(0b0000_0001)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_0000, f: 0b1100_0000)
      end

      it 'should set half carry flag' do
        mmu[0x00] = 0x05

        state.b.write_value(0b0001_0000)

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0b0000_1111, f: 0b0110_0000)
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

        state.h.write_value 0x01
        state.l.write_value 0x02

        state.b.write_value 0x03
        state.c.write_value 0x04

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

        state.h.write_value 0x0F
        state.l.write_value 0xFF

        state.b.write_value 0x0F
        state.c.write_value 0xFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0x0F, c: 0xFF, l: 0xFE, h: 0x1F, f: 0b0010_0000)
      end

      it 'should set carry flag' do
        mmu[0x00] = 0x09

        state.h.write_value 0xFF
        state.l.write_value 0xFF

        state.b.write_value 0xFF
        state.c.write_value 0xFF

        subject.tick

        expect(state).to match_cpu_state(pc: 0x1, b: 0xFF, c: 0xFF, l: 0xFE, h: 0xFF, f: 0b0011_0000)
      end
    end
  end
end