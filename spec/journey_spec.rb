require 'journey'

describe Journey do


  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}


  describe '#start_journey' do

      it 'stores a journey when you #start_journey' do
        subject.start_journey(entry_station)
        expect(subject.journey).to include(:in => entry_station, :out => nil)
      end

  end

  describe '#end_journey' do

      it 'stores a journey when you #end_journey' do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
        expect(subject.journey).to include(:in => entry_station, :out => exit_station)
      end

  end


  describe '#fare' do

    it 'returns the minimum fare when journey complete' do
      subject.start_journey(entry_station)
      subject.end_journey(exit_station)
      expect(subject.fare).to eq Journey::MINIMUM_FARE
    end

    it 'returns penalty fare when touch_in fails' do
      subject.end_journey(entry_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    it 'returns penalty fare when touch_out fails' do
      subject.start_journey(entry_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

  end

end
