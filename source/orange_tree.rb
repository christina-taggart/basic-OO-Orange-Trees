# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_reader :age, :height, :dead

  def initialize
    @age = 0
    @height = 0
    @dead = false
    @number_of_oranges = 0
  end

  # Ages the tree one year
  def age!
    @age < 30 ? @age+=1 : @dead = true
    @height+=2 unless @height==20
    grow_oranges
  end

  def dead?
    @dead
  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @number_of_oranges > 0
  end
  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "Ya can't pick what t'ain't thar!" unless self.any_oranges?
    # orange-picking logic goes here
    @number_of_oranges -= 1
    Orange.new(rand(3..7))
  end

  private

  def grow_oranges
    frost? ? i = 0.75 : i  = 1
    if @age.between?(5,12) || @age.between?(23,30)
      @number_of_oranges+=12*i
    elsif @age.between?(13,22)
      @number_of_oranges+=18*i
    end
  end

  def frost?
    rand(12) == 1
  end
end

class Orange
  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter)
    @diameter = diameter
  end
end

##DRIVER CODE###

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

  avg_diameter = basket.map{|x| x.diameter}.inject(:+)/basket.length

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"