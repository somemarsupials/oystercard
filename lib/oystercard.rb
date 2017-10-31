class Oystercard
  attr_reader :balance

  LIMIT = 90

  def initialize(balance = 0)
    @balance = 0
    top_up(balance)
    self
  end

  def top_up(amount)
    raise "above limit (£#{LIMIT})" if cannot_accept? amount
    @balance += amount
    balance
  end

  def deduct(amount)
    @balance -= amount
  end

  private

  def cannot_accept?(amount)
    balance + amount > LIMIT
  end
end
