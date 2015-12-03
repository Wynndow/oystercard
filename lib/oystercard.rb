require_relative 'journeylog'

class Oystercard
  MAXIMUM_BALANCE = 90
  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  attr_reader :balance, :journeylog

  def initialize
    @balance = 0
    @journeylog = JourneyLog.new
    @previous = :touch_out
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if min_balance?
    @balance -= PENALTY_FARE if @previous == :touch_in
    journeylog.touch_in(station)
    @previous = :touch_in
  end

  def touch_out(station)
    journeylog.touch_out(station)
  if @previous == :touch_out
    @balance -= PENALTY_FARE
  else
    @balance -= journeylog.journey.fare
  end
    @previous = :touch_out
  end

  def current_journey
    journeylog.current_journey
  end


  private

  def min_balance?
    balance < MINIMUM_FARE
  end

  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
