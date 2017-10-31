class Oystercard
  attr_reader :balance, :entry_station

  MINIMUM_FARE = 1
  LIMIT = 90

  def initialize(balance = 0, station = nil)
    @balance = 0
    @entry_station = station
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

  def touch_out
    deduct(MINIMUM_FARE)
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
