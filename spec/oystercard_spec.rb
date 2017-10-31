require 'oystercard'

describe Oystercard do

  let(:limit) { described_class::MINIMUM_FARE }
  let(:touched_in) { described_class.new(50, station) }
  let(:touched_out) { described_class.new(50) }
  let(:station) { double(:station)}

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

    context 'entry station which' do
      it 'is nil by default' do
        expect(subject.entry_station).to be_nil
      end
    end
  end

  describe '#top_up' do
    context 'balance' do

      subject { touched_out }

      it 'increases by 10' do
        expect(subject.top_up(10)).to eq 60
      end

      it 'increases by 20' do
        expect(subject.top_up(20)).to eq 70
      end
    end

    context 'topping up' do
      it 'raises error when amount exceeds 90, starting at 0' do
          expect { subject.top_up(91) }.to raise_error RuntimeError
      end

      it 'raises error when amount exceeds 90, starting at 50' do
        subject = touched_in
        expect { subject.top_up(41) }.to raise_error RuntimeError
      end
    end
  end

  describe '#touch_in' do

    subject { touched_out }

    context 'journey instance variable' do
      it 'becomes true' do
        expect(subject.touch_in('').in_journey?).to be true
      end
    end

    context 'cannot touch in if' do
      it 'balance is insufficient' do
        subject = described_class.new(limit - 0.1)
        expect { subject.touch_in(station) }.to raise_error RuntimeError
      end
    end

    context 'remembers last entry station because it' do
      it 'saves last station in instance variable' do
        expect(subject.touch_in(station).entry_station).to eq station
      end
    end
  end

  describe '#touch_out' do

    subject { touched_in }

    context 'journey instance variable' do
      it 'becomes false' do
        expect(subject.touch_out).to_not be_in_journey
      end
    end

    it 'reduces balance by mimimum amount' do
      expect { subject.touch_out }.to change { subject.balance }.by(-1)
    end
  end
end
