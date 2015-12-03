require_relative 'journey'

class JourneyLog

attr_reader :journey, :journey_history

MINIMUM_FARE = 1


def initialize
  @journey_history = []
  @journey = Journey.new
end

def touch_in(station)
  journey.set_entry(station)
end

def touch_out(station)
  journey.set_exit(station)
  journey_history << journey.current_journey
  journey.touch_out
end


def missed_touch_in?
  journey.missed_touch_in?
end

def current_journey
  journey.current_journey
end


end
