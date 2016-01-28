require_relative 'station.rb'
require_relative 'journey.rb'
require_relative 'journey_log.rb'
require 'forwardable'

class Oystercard

  extend Forwardable

  def_delegator :@journey_log, :journeys, :history
  def_delegator :@journey_log, :record_journey, :record
  def_delegator :@journey, :start_journey, :begin_j
  def_delegator :@journey, :end_journey, :end_j
  def_delegator :@journey, :fare, :fare
  def_delegator :@journey, :journey, :j_hash

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
    if j_hash[:in] != nil
      deduct(fare)
      record
    end
    begin_j(entry_station)
  end

  def touch_out(exit_station)
    end_j(exit_station)
    deduct(fare)
    record
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
