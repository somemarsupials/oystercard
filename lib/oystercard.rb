class Oystercard
  attr_reader :balance

  MINIMUM_FARE = 1
  LIMIT = 90

  def initialize(balance = 0)
    @balance = 0
    @in_journey = false
    top_up(balance)
    self
  end

  def in_journey?
    @in_journey
  end

  def top_up(amount)
    raise "above limit (£#{LIMIT})" if cannot_accept? amount
    @balance += amount
    balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "insufficient balance" if below_minimum?
    @in_journey = true
    self
  end

  def touch_out
    @in_journey = false
    self
  end

  private

  def cannot_accept?(amount)
    balance + amount > LIMIT
  end

  def below_minimum?
    balance < MINIMUM_FARE
  end


end
