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
  end
end