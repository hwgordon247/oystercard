require 'station'

describe Station do

  subject(:station) {described_class.new(name: "Aldgate East")}

  it "should respond to name" do
    expect(subject.name).to eq "Aldgate East"
  end
  it "Should return default subject zone (1)" do
    expect(subject.zone).to eq 1
  end
end
