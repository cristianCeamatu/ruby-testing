class Dog
  MULTIPLIER = 7

  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def public_years
    "#{name} in human years is #{human_years}"
  end

  private

  def human_years
    age * MULTIPLIER
  end
end

dog = Dog.new('Sparky', 25)

p dog.public_years
