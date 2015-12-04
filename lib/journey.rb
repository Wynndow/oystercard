class Journey
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

  def reset_journey
    @current_journey = {}
  end

  def fare
    MINIMUM_FARE + no_zones_crossed
  end

  private

  def no_zones_crossed
    first_zone = @current_journey[:entry_station].zone
    second_zone = @current_journey[:exit_station].zone
    (first_zone - second_zone).abs

  end

end
