require_relative 'station.rb'
require_relative 'journey.rb'


class Oystercard

  attr_reader :balance, :in_use, :entry_station, :exit_station, :journeys

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station, journey = Journey.new)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @journey = journey
    @journey.start_journey(entry_station)
    @journeys << @journey.journey
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MIN)
    @journey.end_journey(exit_station)
  end

  def fare
    deduct(@journey.fare)
    "#{@journey.fare} has been deducted"
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
