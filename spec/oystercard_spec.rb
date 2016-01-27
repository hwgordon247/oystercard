require "oystercard"

describe Oystercard do

  let(:journey) {double(:journey)}
  subject(:oystercard) {described_class.new}

  before do
    allow(journey).to receive(:start_journey)
    allow(journey).to receive(:end_journey)
  end

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

  end

  describe "#touch_out" do

    let(:entry_station) {double(:entry_station)}
    let(:exit_station) {double(:exit_station)}

    it "Cost for journey is deducted on touch_out" do
      allow(entry_station).to receive(:zone).and_return 1
      allow(exit_station).to receive(:zone).and_return 1
      oystercard.instance_variable_set("@balance", 10)
      oystercard.touch_in(entry_station)
      expect {oystercard.touch_out(exit_station)}.to change{oystercard.balance}.by(-1)
    end

  end

end
