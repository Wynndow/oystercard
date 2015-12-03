require_relative 'journeylog'

class Oystercard
  MAXIMUM_BALANCE = 90
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :balance, :journeylog

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if min_balance?
    deduct if journeylog.not_touched_out
    journeylog.touch_in(station)
  end

  def touch_out(station)
    journeylog.touch_out(station)
    deduct
  end


  private

  def min_balance?
    balance < MINIMUM_FARE
  end

  def deduct
    @balance -= journeylog.fare
  end



  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
