require './lib/station.rb'
require './lib/journey.rb'

class Oystercard

  attr_reader :balance, :entry_station, :journey_hist, :journey_complete, :current_journey, :journey_klass

  MAX_LIMIT = 90
  DEFAULT_MIN = 1

  def initialize(journey_klass = Journey)
    @balance = 0
    @journey_klass = journey_klass
    @journey_hist = []
    @current_journey = nil
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{MAX_LIMIT} amount" if @balance + amount > MAX_LIMIT
    @balance += amount
  end

  def touch_in(station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @current_journey ? no_touch_out(station) : new_journey(station)
  end

  def touch_out(station)
    @current_journey == nil ? old_journey(station) : no_touch_in(station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def journey_record
    @journey_hist.push(@current_journey.journey_details)
  end

  def to_pay
    @current_journey.journey_cost
  end

  def no_touch_out(station)
    @current_journey.start_journey(station)
    journey_record
    deduct(to_pay)
    @current_journey = nil
    touch_in(station)
  end

  def new_journey(station)
    @current_journey = @journey_klass.new
    @current_journey.start_journey(station)
  end

  def no_touch_in(station)
    @current_journey.end_journey(station)
    journey_record
    deduct(to_pay)
    @current_journey = nil
  end

  def old_journey(station)
    @current_journey = @journey_klass.new
    touch_out(station)
  end
end
