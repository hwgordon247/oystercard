require 'journey_log'

describe JourneyLog do

  let(:journey) {double :journey}
  let(:station1) {double :station}
  let(:station2) {double :station}
  let(:journey_hash) {{:in => station1, :out => station2}}
  subject(:journeylog) {described_class.new journey}

  before do
    allow(journey).to receive(:journey).and_return journey_hash
    allow(journey).to receive(:reset)
  end

  describe '#journeys' do
    it{is_expected.to respond_to(:journeys)}

    it 'returns current journey array' do
      subject.record_journey
      expect(subject.journeys).to include journey_hash
    end
  end

  describe '#record_journey' do

    it 'pushes the current journey into the log file' do
      expect{subject.record_journey}.to change{subject.journeys}.by [journey_hash]
    end
  end
end
