# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class FruitTree

end

class OrangeTree
  attr_accessor :height, :age
  # Ages the tree one year

  def initialize(age = 0, height = 3)
    @age = age
    @height = height
    @basket = []
  end

  def age!
    @age +=1
    @age > 8 ? @height : @height += 1

  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @age > 5 && alive? ? true : false
  end

  def alive?
    !dead?
  end

  def dead?
    true if @age > 15
  end
  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    # orange-picking logic goes here
    age!
  end
end

class Orange
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter)
    @diameter = diameter
  end
end

class AppleTree < FruitTree
  attr_accessor :height, :age
  # Ages the tree one year

  def initialize(age = 0, height = 3)
    @age = age
    @height = height
    @basket = []
  end

  def age!
    @age +=1
    @age > 15 ? @height : @height += 1

  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_apples?
    @age > 5 && alive? ? true : false
  end

  def alive?
    !dead?
  end

  def dead?
    true if @age > 15
  end
  def pick_an_apple!
    raise NoAppleError, "This tree has no oranges" unless self.any_apple?
    age!
  end
end

class Apple
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter)
    @diameter = diameter
  end
end

# oranges = Orange.new(3)
# my_tree = OrangeTree.new
# my_tree.age!
# my_tree.age!
# my_tree.age!
# p my_tree.any_oranges?
# my_tree.age!
# my_tree.age!
# p my_tree.any_oranges?
# my_tree.age!
# my_tree.age!
# p my_tree.any_oranges?
# my_tree.pick_an_orange!

tree = OrangeTree.new
goodmans = Orange.new(5)
p goodmans.diameter

tree.age! until tree.any_oranges?

puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

until tree.dead?
  basket = []

  # It places the oranges in the basket
  # IT PLACES THE ORANGES IN THE BASKET
  while tree.any_oranges?
    basket << tree.pick_an_orange!
  end

  avg_diameter = goodmans.diameter# It's up to you to calculate the average diameter for this harvest.

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"
