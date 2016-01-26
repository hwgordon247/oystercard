
class Journey

  attr_reader :journey, :journeys

  def initialize
    @journey = {:in => nil, :out => nil}
    @journeys = []
  end

  def start_journey(entry_station)
    @journey = {:in => nil, :out => nil}
    @journey[:in]=entry_station
    @journeys << @journey
  end

  def end_journey(exit_station)
    @journey[:out]=exit_station
  end

  def in_journey?
    !!@entry_station
  end

end
