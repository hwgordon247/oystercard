require './lib/oystercard.rb'

class Journey
  attr_reader :entry_station, :start_journey, :journey_details, :exit_station, :journey_cost, :in_journey

  PEN_FARE = 6
  STANDARD_FARE = 1

  def initialize
    @journey_cost = 0
    @in_journey = false
    @entry_station = nil
    @exit_station = nil
  end

  def start_journey(entry_station)
    @in_journey ? start_in_journey : start_no_journey(entry_station)
  end

  def journey_complete
    @journey_details = { @entry_station => @exit_station }
    fare
  end

  def end_journey(exit_station)
    @in_journey == false ? end_no_journey(exit_station) : end_in_journey(exit_station)
  end

  private

  def fare
    @in_journey ? @journey_cost = PEN_FARE : @journey_cost = STANDARD_FARE
  end

  def start_no_journey(entry_station)
    @entry_station = entry_station
    @in_journey = true
  end

  def start_in_journey
    @exit_station = "no touch out"
    journey_complete
    @in_journey = false
  end

  def end_no_journey(end_station)
    @in_journey = true
    @entry_station = "no touch in"
    @exit_station = exit_station
    journey_complete
  end

  def end_in_journey(exit_station)
    @exit_station = exit_station
    @in_journey = false
    journey_complete
  end
end
