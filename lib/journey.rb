require_relative 'station.rb'

class Journey
  attr_reader :record_journey

  def initialize(entry_station)
    @record_journey = {}
    start_journey(entry_station)
  end

  def end_journey(exit_station)
    @entry_station = nil
    @record_journey[:exit] = exit_station
  end

  def fare
  end
  
  def start_journey(entry_station)
  	@record_journey[:entry] = entry_station
  end

end
