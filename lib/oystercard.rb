require_relative 'station.rb'

class Oystercard

  attr_reader :balance, :in_use, :entry_station, :exit_station, :journeys

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize
    @balance = 0
    @entry_station = nil
    @journeys = []
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station)
    @journey = {:in => nil, :out => nil}
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @entry_station = entry_station
    @journey[:in]=entry_station
    @journeys << @journey
  end

  def touch_out(exit_station)
    deduct(DEFAULT_MIN)
    @entry_station = nil
    @journey[:out]=exit_station
  end

  def in_journey?
    !!@entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
