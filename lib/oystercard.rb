require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard

  attr_reader :balance, :in_use, :entry_station, :exit_station

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize
    @balance = 0
    @journey_log = JourneyLog.new
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @journey = Journey.new
    @journey_log.start_journey(entry_station)
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MIN)
    @journey_log.end_journey(exit_station)
  end

  def journeys
    @journey_log.journeys
  end

  def fare
    @journey.fare(@journey_log.journey)
  end


  private

  def deduct(amount)
    @balance -= amount
  end

end
