require_relative 'journey'

class JourneyLog

attr_reader :journey

extend Forwardable

def initialize(journey: Journey.new)
  @journey_history = []
  @journey = journey
end

def_delegators :@journey, :current_journey, :fare, :set_entry

def touch_out(station)
  journey.set_exit(station)
  @journey_history << journey.current_journey
  journey.touch_out
end

def journey_history
  @journey_history.dup
end


end
