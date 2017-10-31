require 'oystercard'

describe Oystercard do

  let(:limit) { described_class::MINIMUM_FARE }
  let(:touched_in) { described_class.new(50, true) }
  let(:touched_out) { described_class.new(50) }

  describe 'creates with' do
    context 'in_journey? which' do
      it 'is 0 by default' do
        expect(subject).to_not be_in_journey
      end
    end

    context 'balance which' do
      it 'is 0 by default' do
        expect(subject.balance).to eq 0
      end

      it 'has a given value when not default balance' do
        expect(touched_out.balance).to eq 50
      end
    end
  end

  describe '#top_up' do
    context 'balance' do

      it 'increases by 10' do
        expect(touched_out.top_up(10)).to eq 60
      end

      it 'increases by 20' do
        expect(touched_out.top_up(20)).to eq 70
      end
    end

    context 'topping up' do
      it 'raises error when amount exceeds 90, starting at 0' do
        expect { subject.top_up(91) }.to raise_error RuntimeError
      end

      it 'raises error when amount exceeds 90, starting at 50' do
        expect { touched_out.top_up(41) }.to raise_error RuntimeError
      end
    end
  end

  describe '#touch_in' do

    context 'journey instance variable' do
      it 'becomes true' do
        expect(touched_in.touch_in.in_journey?).to be true
      end
    end

    context 'cannot touch in if' do
      it 'balance is insufficient' do
        subject = described_class.new(limit - 0.1)
        expect { subject.touch_in }.to raise_error RuntimeError
      end
    end
  end

  describe '#touch_out' do
    subject { described_class.new(30)}

    context 'journey instance variable' do
      it 'becomes false' do
        expect(touched_in.touch_out.in_journey?).to be false
      end
    end

    it 'reduces balance by mimimum amount' do
      expect { touched_in.touch_out }.to change { touched_in.balance }.by(-1)
    end
  end

end
