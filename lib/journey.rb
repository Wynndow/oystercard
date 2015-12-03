require_relative 'journeylog'

class Journey

attr_reader :current_journey, :fare

MINIMUM_FARE = 1
PENALTY_FARE = 6

def initialize
  @current_journey = {}
  @fare = 0
end

def set_entry(station, touched_out_last_journey = true)
  @fare = PENALTY_FARE unless touched_out_last_journey
  @current_journey[:entry_station] = station
end

def set_exit(station)
  @current_journey[:entry_station] ||= nil
  @current_journey[:exit_station] = station
  @fare = MINIMUM_FARE
  @fare = PENALTY_FARE if current_journey[:entry_station] == nil
end

def clear_current_journey
  @current_journey = {}
end

def complete_journey_if_no_touch_out
  @current_journey[:exit_station] = nil
end

end
