require 'journey'

describe Journey do


  let(:entry_station) {double(:entry_station)}
  let(:exit_station) {double(:exit_station)}


  describe '#start_journey' do

      it 'stores a journey when you #start_journey' do
        subject.start_journey(entry_station)
        expect(subject.journeys).to include(:in => entry_station, :out => nil)
      end

  end

  describe '#end_journey' do

      it 'stores a journey when you #end_journey' do
        subject.start_journey(entry_station)
        subject.end_journey(exit_station)
        expect(subject.journeys).to include(:in => entry_station, :out => exit_station)
      end

  end



  # describe "#in_journey" do
  #
  #   let(:entry_station) {double(:entry_station)}
  #
  #   it "Card shows as in_journey after touch_in" do
  #     oystercard.top_up(1)
  #     oystercard.touch_in(entry_station)
  #     expect(oystercard).to be_in_journey
  #   end
  #
  # end

  # describe "#journeys" do
  #
  #   let(:entry_station) {double(:entry_station, :name => 'name', :zone => 1)}
  #   let(:exit_station) {double(:exit_station, :name => 'name', :zone => 1)}
  #
  #   it "can store a full journey in the journey history" do
  #     oystercard.top_up(10)
  #     oystercard.touch_in(entry_station)
  #     oystercard.touch_out(exit_station)
  #     expect(oystercard.journeys).to include(:in => entry_station, :out => exit_station)
  #   end
  #
  #
  # end

end
