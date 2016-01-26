require "oystercard"

describe Oystercard do
subject(:oystercard) {described_class.new}

  describe "#initialize" do
    it "Shows a balance of 0 on new card" do
      expect(oystercard.balance).to eq 0
    end
  end

  describe "#top_up" do

    it "Allows balance to be topped up" do
      expect(oystercard.top_up(10)).to eq oystercard.balance
    end
  end

  describe "#top_up maximum" do

    it "Prevents balance being topped up beyond default max" do
      oystercard.instance_variable_set("@balance", 1)
      expect{oystercard.top_up(Oystercard::DEFAULT_MAX)}.to raise_error("Unable to top up balance to above #{Oystercard::DEFAULT_MAX} amount")
    end

  end

  describe "#touch_in" do

    let(:entry_station) {double(:entry_station)}

    it "Check min balance on touch_in" do
      expect{oystercard.touch_in(entry_station)}.to raise_error("Balance under #{Oystercard::DEFAULT_MIN}")
    end

    it "Records the station of departure at touch_in" do
      oystercard.instance_variable_set("@balance", 1)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq entry_station
    end

  end

  describe "#touch_out" do

    let(:entry_station) {double(:entry_station)}
    let(:exit_station) {double(:exit_station)}

    it "Cost for journey is deducted on touch_out" do
      oystercard.instance_variable_set("@balance", 10)
      oystercard.touch_in(entry_station)
      expect {oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-1)
    end

  end

  describe "#in_journey" do

    let(:entry_station) {double(:entry_station)}

    it "Card shows as in_journey after touch_in" do
      oystercard.top_up(1)
      oystercard.touch_in(entry_station)
      expect(oystercard).to be_in_journey
    end

  end

  describe "#journeys" do

    let(:entry_station) {double(:entry_station)}
    let(:exit_station) {double(:exit_station)}

    it "can store a full journey in the journey history" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.journeys).to include(:in => entry_station, :out => exit_station)
    end


  end

end
