require_relative 'journey.rb'

class JourneyLog

  def initialize journey_instance=Journey.new
    @journey = journey_instance
    @journeys = []
  end

  def journeys
    @journeys.clone
  end

  def record_journey
    @journeys << @journey.journey
    @journey.reset
  end

end
