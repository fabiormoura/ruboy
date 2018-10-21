require_relative '../../spec_helper'



RSpec.describe Emulator::Cpu::Cpu do
  let(:mmu) {Emulator::MmuStub.new}
  let(:runtime_context) {Emulator::Cpu::RuntimeContext.new}

  subject {described_class.new(mmu: mmu, context: runtime_context)}

  context 'instructions' do
    context 'NOP' do
      it 'should execute instruction' do
        mmu[0x00] = 0x00
        subject.tick
        expect(runtime_context).to match_cpu_context(pc: 0x1)
      end
    end
  end
end