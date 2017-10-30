class Oystercard
  # attribute reader  = makes balance accessible outside the class
  attr_reader :balance

  CREDIT_LIMIT = 90

  def initialize(balance = 0)
    # illustration of defensive programming
    @balance = 0
    top_up(balance)
  end

  def top_up(amount)
    raise RuntimeError, "above limit (£#{CREDIT_LIMIT})" if overloads?(amount)
    @balance += amount
    balance
  end

  private

  def overloads?(amount)
    balance + amount > CREDIT_LIMIT
  end
end
