# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_accessor :height, :age
  # Ages the tree one year

  def initialize(age = 0, height = 3)
    @age = age
    @height = height
  end

  def age!
    @age +=1
    @age > 10 ? @height : @height += 1
  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @age > 5 ? true : false
  end

  def dead?
    @age > 24 ? true : false
  end
  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?

    # orange-picking logic goes here
  end
end

class Orange
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter)
    @diameter = diameter
  end
end