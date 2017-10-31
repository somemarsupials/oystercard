require 'oystercard'

describe Oystercard do
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
        expect(Oystercard.new(10).balance).to eq 10
      end
    end
  end

  describe '#top_up' do
    context 'balance' do
      subject { described_class.new(10) }

      it 'increases by 10' do
        expect(subject.top_up(10)).to eq 20
      end

      it 'increases by 20' do
        expect(subject.top_up(20)).to eq 30
      end
    end

    context 'topping up' do
      it 'raises error when amount exceeds 90, starting at 0' do
        expect { subject.top_up(91) }.to raise_error RuntimeError
      end

      it 'raises error when amount exceeds 90, starting at 20' do
        subject = described_class.new(20)
        expect { subject.top_up(71) }.to raise_error RuntimeError
      end
    end
  end

  describe '#deduct' do

    subject { described_class.new(30) }

    context 'removes' do
      it '10 from balance' do
        expect { subject.deduct(10) }.to change { subject.balance }.by(-10)
      end

      it '20 from balance' do
        expect { subject.deduct(20) }.to change { subject.balance }.by(-20)
      end
    end
  end

describe '#touch_in' do
  context 'journey instance variable' do
    it 'becomes true' do
      expect(subject.touch_in.in_journey?).to be true
    end
  end
end

describe '#touch_out' do
  context 'journey instance variable' do
    it 'becomes false' do
      expect(subject.touch_out.in_journey?).to be false
    end
  end
end


end
