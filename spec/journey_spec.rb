require 'journey'

describe Journey do

  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}

  before(:example) do
    allow(entry_station).to receive(:zone).and_return(2)
    allow(exit_station).to receive(:zone).and_return(5)
    subject.start_journey(entry_station)
  end

   describe '#start_journey' do
      it 'stores a journey when you #start_journey' do
        expect(subject.journey).to include(:in => entry_station, :out => nil)
      end
   end

   describe '#end_journey' do
      it 'stores a journey when you #end_journey' do
         subject.end_journey(exit_station)
        expect(subject.journey).to include(:in => entry_station, :out => exit_station)
      end
   end

   describe '#fare' do
    it 'returns penalty fare when touch_in fails' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns penalty fare when touch_out fails' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns a fare for different zone journeys' do
      subject.end_journey(exit_station)
      expect(subject.fare).to eq 4
    end
  end
end
