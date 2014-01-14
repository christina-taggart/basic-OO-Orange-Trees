require 'pry'
require 'pry-nav'
# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_accessor :age, :height
  def initialize
    @age = 0
    @height = 0
    @number_of_oranges = 10
  end

  # Ages the tree one year
  def age!
      @age += 1
      @height += 1
      @number_of_oranges = 10
  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @age.between?(14,30) && @number_of_oranges != 0
  end

  def dead?
    @age == 40 ? true : false
  end

  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
     orange = Orange.new
     @number_of_oranges -= 1
     orange
  end

end

class Orange
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize
    @diameter = rand(4..6)
  end
end






tree = OrangeTree.new

tree.age! until tree.any_oranges?
p tree.pick_an_orange!
puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

until tree.dead?
  basket = []


  # It places the oranges in the basket
  # IT PLACES THE ORANGES IN THE BASKET
  while tree.any_oranges?
    basket << tree.pick_an_orange!
  end

avg_diameter = basket.map{ |orange| orange.diameter }.inject(:+) / basket.length

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"