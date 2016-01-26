class Oystercard

  attr_reader :balance, :in_use, :entry_station

  DEFAULT_MAX = 90
  DEFAULT_MIN = 1

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(amount)
    raise "Unable to top up balance to above #{DEFAULT_MAX} amount" if @balance + amount > DEFAULT_MAX
    @balance += amount
  end

  def touch_in(entry_station)
    raise "Balance under #{DEFAULT_MIN}" if @balance < DEFAULT_MIN
    @entry_station = entry_station
  end

  def touch_out
    deduct(DEFAULT_MIN)
    @entry_station = nil
  end

  def in_journey?
    @entry_station ? true : false
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
