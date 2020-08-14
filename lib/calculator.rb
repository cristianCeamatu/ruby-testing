class Calculator
  def add(*args)
    args.inject(:+)
  end

  def multiply(*args)
    args.inject(:*)
  end

  def substract(*args)
    args.inject(:-)
  end

  def divide(*args)
    args.inject(:/)
  end
end