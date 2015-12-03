require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journey

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(value)
    @balance += value
  end

  def touch_in(station)
    @balance -= 6 if in_journey?
    fail "Insufficent funds: top up" if min_balance?
    journey.touch_in(station)
  end

  def touch_out(station)
    journey.touch_out(station)
    deduct(MINIMUM_FARE)
  end


  private

  def start_new_journey
    Journey.new
  end

  def deduct(value)
    value = 6 if missed_touch_out?
    @balance -= value
  end

  def missed_touch_out?
    journey.journey_history[-1][:entry_station] == nil
  end

  def min_balance?
    balance < MINIMUM_FARE
  end

  def in_journey?
    !!journey.current_journey[:entry_station]
  end

  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
