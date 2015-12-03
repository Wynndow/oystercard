require_relative 'journeylog'

class Oystercard
  MAXIMUM_BALANCE = 90
  PENALTY_FARE = 6
  MINIMUM_BALANCE = 1

  attr_reader :balance, :journeylog

  extend Forwardable

  def initialize(journeylog: JourneyLog.new)
    @balance = 0
    @journeylog = journeylog
    @previous = :touch_out
  end

  def_delegators :@journeylog, :current_journey, :fare, :journey_history

  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficent funds: top up" if min_balance?
    @balance -= PENALTY_FARE if @previous == :touch_in
    journeylog.set_entry(entry_station)
    @previous = :touch_in
  end

  def touch_out(exit_station)
    journeylog.log_new_journey(exit_station)
    @previous == :touch_out ? @balance -= PENALTY_FARE : @balance -= fare
    @previous = :touch_out
  end


  private

  def min_balance?
    balance < MINIMUM_BALANCE
  end

  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end
end
