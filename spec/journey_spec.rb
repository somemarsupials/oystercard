require 'journey'

class MockStation
  attr_reader :name, :zone
  def initialize(name, zone)
    @name = name
    @zone = zone
  end
end

describe Journey do

  subject { Journey.new(entry, _exit) }
  let(:entry) { MockStation.new(:Waterloo, 1) }
  let(:_exit) { MockStation.new(:Euston, 2) }

  describe 'creates with' do
    context 'entry which' do
      it 'is the station Waterloo' do
        expect(subject.entry).to eq entry
      end
    end

    context 'exit which' do
      it 'is the station Euston' do
        expect(subject.exit).to eq _exit
      end
    end
  end
end
