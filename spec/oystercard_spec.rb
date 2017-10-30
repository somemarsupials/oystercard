require 'oystercard'



describe Oystercard do

  # without any other information, subject == Oystercard.new

  describe "creates with" do
    context "balance which" do
      it 'is 0 by default' do
        expect(subject.balance).to eq 0
      end

      it 'has a given value when not default balance' do
        expect(Oystercard.new(10).balance).to eq 10
      end
    end
  end

  describe '#top_up' do
    context "balance" do

      # start of the context block
      subject { described_class.new(10) }

      it 'increases by 10' do
        expect(subject.top_up(10)).to eq 20
      end

      it 'increases by 20' do
        expect(subject.top_up(20)).to eq 30
      end
      # end of the context block
    end

    context 'topping up' do
      it 'raises an error when amount is above 90, starting at 0' do
        expect { subject.top_up(91) }.to raise_error RuntimeError
      end

      it 'raises an error when amount is above 90, starting at 20' do
        subject = described_class.new(20)
        expect { subject.top_up(71) }.to raise_error RuntimeError
      end
    end
  end
end
