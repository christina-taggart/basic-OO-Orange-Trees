# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_reader :age, :height

  def initialize
    @age = 0
    @height = 0
    @oranges = []
  end
  # Ages the tree one year
  def age!
    @age += 1
    if @age < 30
      @height += 1
      @oranges = (1..(3*age)).to_a.map { |orange| Orange.new((rand(100) + 1).to_f / 25)}
    end
  end

  def dead?
    @age > 60
  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @oranges.empty? == false
  end

  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?

    # orange-picking logic goes here
    @oranges.pop
  end
end

class Orange
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter)
    @diameter = diameter
  end
end


tree = OrangeTree.new

tree.age! until tree.any_oranges?

puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

until tree.dead?
  basket = []

  # It places the oranges in the basket
  # IT PLACES THE ORANGES IN THE BASKET
  while tree.any_oranges?
    basket << tree.pick_an_orange!
  end

  avg_diameter = basket.map{|orange| orange.diameter}.inject(:+) / basket.length unless basket.empty?# It's up to you to calculate the average diameter for this harvest.

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"