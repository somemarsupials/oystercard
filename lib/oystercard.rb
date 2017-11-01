require 'station'

class Oystercard
  attr_reader :balance, :entry_station, :journeys

  MINIMUM_FARE = 1
  LIMIT = 90

  def initialize(balance = 0, station = nil, journey_class = Journey)
    @balance = 0
    @entry_station = station
    @journeys = []
    @journey_class = Journey
    top_up(balance)
    self
  end

  def in_journey?
    !!@entry_station
  end

  def top_up(amount)
    raise "above limit (£#{LIMIT})" if cannot_accept? amount
    @balance += amount
    balance
  end

  def touch_in(station)
    raise "insufficient balance" if below_minimum?
    @entry_station = station
    self
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    journeys << @journey_class.new(entry_station, exit_station)
    @entry_station = nil
    self
  end

  private

  def cannot_accept?(amount)
    balance + amount > LIMIT
  end

  def below_minimum?
    balance < MINIMUM_FARE
  end

  def deduct(amount)
    @balance -= amount
  end


end
