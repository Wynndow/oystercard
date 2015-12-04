require_relative 'journey'

class JourneyLog

attr_reader :journey

extend Forwardable

def initialize(journey: Journey.new)
  @journey_history = []
  @journey = journey
end

def_delegators :@journey, :current_journey, :fare, :set_entry, :set_exit

def log_new_journey
  @journey_history << journey.current_journey
  journey.reset_journey
end

def journey_history
  @journey_history.dup
end


end
