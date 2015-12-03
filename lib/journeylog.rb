class JourneyLog


attr_reader :journey, :journey_history, :touched_out_last_journey


def initialize(journey: Journey.new)
  @journey_history = []
  @journey = journey
  @touched_out_last_journey = false
end

def journeys
  @journey_history
end

def start_journey(station, journey: Journey.new)
  complete_journey if currently_in_journey
  @journey = journey
  touched_out_last_journey
  journey.set_entry(station, touched_out_last_journey)
end

def exit_journey(station)
  journey.set_exit(station)
  add_current_journey_to_history
  journey.clear_current_journey
end

def current_journey
  journey.current_journey
end

def outstanding_charges
  journey.fare
end


private

def complete_journey
  journey.complete_journey_if_no_touch_out
  add_current_journey_to_history
end

def currently_in_journey
  journey.current_journey[:entry_station]
end

def touched_out_last_journey
  return @touched_out_last_journey = true if journey_history.empty?
  return @touched_out_last_journey = true if journey_history[-1][:exit_station]
  @touched_out_last_journey = false
end

def add_current_journey_to_history
  journey_history << journey.current_journey
end

end
