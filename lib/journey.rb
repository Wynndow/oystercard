class Journey

attr_reader :journey_history, :current_journey

MINIMUM_FARE = 1
PENALTY_FARE = 6

def initialize
  @journey_history = []
  @current_journey = {}
end

def touch_in(station)
  set_entry(station)
end

def touch_out(station)
  set_exit(station)
  @journey_history << current_journey
  @current_journey = {}
end

def fare
  return PENALTY_FARE if missed_touch_in?
  return PENALTY_FARE if missed_touch_out?
  return MINIMUM_FARE
end

def not_touched_out
  missed_touch_in?
end

private

def penalty_due
end

def set_entry(station)
  @current_journey[:entry_station] = station
end

def set_exit(station)
  @current_journey[:exit_station] = station
end

def missed_touch_out?
  return false if journey_history.empty?
  journey_history[-1][:entry_station] == nil
end

def missed_touch_in?
  !!current_journey[:entry_station]
end


end
