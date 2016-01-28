require_relative 'journey.rb'
require 'forwardable'

class JourneyLog

  extend Forwardable

  def_delegator :@journey, :journey, :current_trip
  def_delegator :@journey, :reset, :reset
  def_delegator :@journeys, :push, :cram
  def_delegator :@journeys, :clone, :journeys

  def initialize journey_instance=Journey.new
    @journey = journey_instance
    @journeys = []
  end

  def record_journey
    cram current_trip
    reset
  end

end
