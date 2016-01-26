
class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_reader :journey

  def initialize
    @journey = {:in => nil, :out => nil}
  end

  def start_journey(entry_station)
    @journey = {:in => nil, :out => nil}
    @journey[:in]=entry_station
  end

  def end_journey(exit_station)
    @journey[:out]=exit_station
  end

  def fare
    if @journey[:out] == nil || @journey[:in] == nil
      PENALTY_FARE
    else
      MINIMUM_FARE
    end
  end

end
