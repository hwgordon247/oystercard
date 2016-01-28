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
    # @journeys = []
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @journey.reset
    @journey.start_journey(entry_station)
    # @journeys << @journey.journey
  end

  def touch_out(exit_station)
    if @journey.journey[:out] != nil
      @journey.reset
      #@journeys << @journey.journey
    end
    @journey.end_journey(exit_station)
    fare
  end

  def history
    @journey_log.journeys
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
