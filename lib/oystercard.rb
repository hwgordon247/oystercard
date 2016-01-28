require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard

  attr_reader :balance, :in_use, :entry_station, :exit_station, :journeys

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(journey_log = JourneyLog.new(journey = Journey.new))
    @journey = journey
    @journey_log = journey_log
    @balance = 0
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    if @journey.journey[:in] != nil #illegal travel
      deduct(@journey.fare)
      @journey_log.record_journey
    end
    @journey.start_journey(entry_station)  #lawful travel
  end

  def touch_out(exit_station)
      @journey.end_journey(exit_station)
      deduct(@journey.fare)
      @journey_log.record_journey
  end

  def history
    @journey_log.journeys
  end

  private
  def deduct(amount)
    @balance -= amount
  end
end
