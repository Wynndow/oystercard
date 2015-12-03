class Journey
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :current_journey
  def initialize
    @current_journey = {}
  end

  def set_entry(station)
    @current_journey[:entry_station] = station
  end

  def set_exit(station)
    @current_journey[:exit_station] = station
  end

  def touch_out
    @current_journey = {}
  end

  def missed_touch_in?
    !!current_journey[:entry_station]
  end

  def missed_touch_out?
      !!!current_journey[:entry_station]
  end

  def fare
    return MINIMUM_FARE
  end

end
