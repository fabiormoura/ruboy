require_relative '../../spec_helper'

RSpec.describe Emulator::Cpu::Cpu do
  let(:mmu) {Emulator::MmuStub.new}
  let(:runtime_context) {Emulator::Cpu::State.new}

  subject {described_class.new(mmu: mmu, context: runtime_context)}

  context 'instructions' do
    context 'NOP' do
      it 'should execute instruction' do
        mmu[0x00] = 0x00
        subject.tick
        expect(runtime_context).to match_cpu_state(pc: 0x1)
      end
    end

    context 'LD BC,d16' do
      it 'should execute instruction' do
        mmu[0x00] = 0x01
        mmu[0x01] = 0xAB
        mmu[0x02] = 0xCD
        subject.tick
        expect(runtime_context).to match_cpu_state(pc: 0x3, b: 0xCD, c: 0xAB)
      end
    end
  end
end