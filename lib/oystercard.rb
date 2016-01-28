require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'


class Oystercard

  attr_reader :balance
  @@error = "Unable to complete action: "

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize(journey_log = JourneyLog.new(journey = Journey.new))
    @journey = journey
    @journey_log = journey_log
    @balance = 0
  end

  def top_up(amount)
    raise @@error + "high balance" if high_balance?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    raise @@error + "low balance" if low_balance?
    if @journey.journey[:in] != nil
      deduct(@journey.fare)
      @journey_log.record_journey
    end
    @journey.start_journey(entry_station)
  end

  def touch_out(exit_station)
      @journey.end_journey(exit_station)
      deduct(@journey.fare)
      @journey_log.record_journey
  end

  def history
    @journey_log.journeys.clone
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def high_balance?(amount)
    @balance + amount > DEFAULT_MAX ? true : false
  end

  def low_balance?
    @balance < DEFAULT_MIN ? true : false
  end

end
