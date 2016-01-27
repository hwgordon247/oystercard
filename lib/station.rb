require_relative 'oystercard.rb'

class Station

  attr_reader :specific_station, :zone

  def initialize(specific_station:, zone: nil)
    @specific_station = specific_station
    @zone = zone
  end
end
