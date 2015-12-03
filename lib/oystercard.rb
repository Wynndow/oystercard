require_relative 'journey'

class Oystercard
  MAXIMUM_BALANCE = 90
  PENALTY_FARE = 6
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
    fail "Insufficent funds: top up" if min_balance?
    deduct if journey.not_touched_out
    journey.touch_in(station)
  end

  def touch_out(station)
    journey.touch_out(station)
    deduct
  end


  private

  def start_new_journey
    Journey.new
  end

  def min_balance?
    balance < MINIMUM_FARE
  end

  def deduct
    @balance -= journey.fare
  end



  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
