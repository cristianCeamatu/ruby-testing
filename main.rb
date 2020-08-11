module Walkable
  def walk
    "I'm walking."
  end
end

module Swimmable
  def swim
    "I'm swimming."
  end
end

module Climbable
  def climb
    "I'm climbing."
  end
end

class Animal
  include Walkable
  include Climbable

  def speak
    "I'm an animal, and I speak!"
  end
end

puts Animal.ancestors

fido = Animal.new
p fido.climb
