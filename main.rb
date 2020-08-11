module Mammal
  class Dog
    def speak(sound)
      p "#{sound}"
    end
  end

  class Cat
    def say_name(name)
      p "#{name}"
    end
  end

  def self.expo(num)
    num ** 2
  end
end

dog = Mammal::Dog.new

dog.speak('woff woff')

p Mammal::expo(8)