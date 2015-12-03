require_relative 'journey'
require_relative 'journeylog'


class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_FARE = 1

  attr_reader :balance, :journeylog

  def initialize(journeylog: JourneyLog.new)
    @balance = 0
    @journeylog = journeylog
  end

  def top_up(value)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(value)
    @balance += value
  end

  def touch_in(station)
    fail "Insufficent funds: top up" if min_balance?
    journeylog.start_journey(station)
    deduct
  end

  def touch_out(station)
    journeylog.exit_journey(station)
    deduct
  end


  private

  def min_balance?
    balance < MINIMUM_FARE
  end

  def deduct
    @balance -= journeylog.outstanding_charges
  end

  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
