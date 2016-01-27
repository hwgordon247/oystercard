require 'station.rb'

describe Station do

  let(:specific_station) {double :specific_station}
  let(:zone) {double :zone}

  subject(:station) {Station.new(specific_station: "Aldgate", zone: 1)}

  describe "#initialization" do
    it "Should initialize with station name" do
      expect(station.specific_station).to eq "Aldgate"
    end

    it "Should initialize with a zone integer" do
      expect(station.zone).to eq 1
   end
  end

  describe "whatever comes next" do

  end
end
