class JourneyLog

def initialize
  @journey_history = []
end


def journey_history
  @journey_history
end

def missed_touch_out?
  return false if journey_history.empty?
  journey_history[-1][:entry_station] == nil
end



end
