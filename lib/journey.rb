class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  #attr_reader :journey

  def initialize
    @journey = {:in => nil, :out => nil}
  end

  def start_journey(entry_station)
    @entry_station = entry_station
    @journey[:in] = @entry_station
  end

  def end_journey(exit_station)
    @exit_station = exit_station
    @journey[:out] = @exit_station
  end

  def journey
    @journey.clone
  end

  def fare
    # total = []
    return PENALTY_FARE if @journey[:out].nil? || @journey[:in].nil?
    # total << @entry_station.zone
    # total << @exit_station.zone
    total = [@entry_station.zone, @exit_station.zone]
    total.sort!
    total[0] != total[1] ? ((total[1]-total[0])+1) : MINIMUM_FARE
  end

  def reset
    @journey = {:in => nil, :out => nil}
  end
end
