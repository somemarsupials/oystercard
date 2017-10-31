require 'station'

describe Station do
  subject {Station.new(:Waterloo)}

  describe 'creates with' do
    context 'name which' do
       it "is Waterloo" do
         expect(subject.name).to eq(:Waterloo)
       end
    end

    context 'zone which' do
      it 'is 1' do
        expect(subject.zone).to eq(1)
      end
    end
  end
end
