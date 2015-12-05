require_relative 'station'
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

  def_delegators :@journeylog, :current_journey, :fare, :journey_history, :set_exit, :set_entry, :log_new_journey, :reset_journey

  def top_up(amount)
    fail "Maximum balance of £#{MAXIMUM_BALANCE} exceeded" if over_capacity?(amount)
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Insufficent funds: top up" if min_balance?
    @balance -= PENALTY_FARE if @previous == :touch_in
    touch_in_journey_effect(entry_station)
  end

  def touch_out(exit_station)
    set_exit(exit_station)
    @previous == :touch_out ? @balance -= PENALTY_FARE : @balance -= fare
    touch_out_journey_effect
  end


  private

  def min_balance?
    balance < MINIMUM_BALANCE
  end

  def over_capacity?(value)
    value + balance > MAXIMUM_BALANCE
  end

  def touch_in_journey_effect(entry_station)
    set_entry(entry_station)
    @previous = :touch_in
  end

  def touch_out_journey_effect
    log_new_journey
    reset_journey
    @previous = :touch_out
  end
end
