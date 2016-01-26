

class JourneyLog
  attr_reader :journeys, :journey

  def initialize
    @journeys = []
    #@journey_fares = Journey.new
    @journey = {:in => nil, :out => nil}
  end

  def start_journey(entry_station)
    @journey = {:in => nil, :out => nil}
    @journey[:in]=entry_station
    @journeys << @journey
  end

  def end_journey(exit_station)
    @journey[:out]=exit_station
  end

end
