class Animal
  attr_accessor :name

  def initialize; end
end

class Dog < Animal
  def initialize(name, color)
    super
    @color = color
  end

  def speak
    "But #{@name} - eyes #{@color} says Bark Bark"
  end
end

dog = Dog.new('Red', 'Cristian')

puts dog.speak
