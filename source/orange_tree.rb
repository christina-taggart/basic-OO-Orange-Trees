# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_reader :height, :age, :dead

  def initialize
    @height = 0
    @age = 0
    @oranges = []
    @dead = false
  end

  def age!
    @dead = true if @age >= 20
    if dead?
      puts "This tree has died and can age no more."
    else
      @age +=1
      @height += growth_formula if age <= 7
      grow_oranges if growing_age?
    end
  end

  def any_oranges?
    !@oranges.empty?
  end

  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @oranges.shift
  end

  def dead?
    @dead
  end

  private

  def growing_age?
    age >= 4
  end

  def growth_formula
    (5.0 / @age).ceil
  end

  def grow_oranges
    orange_diameters = [3, 4, 5, 6, 3, 5, 6, 3, 4, 4, 12]
    rand(20).times { @oranges << Orange.new(orange_diameters.sample)}
  end
end

class Orange
  attr_reader :diameter

  def initialize(diameter)
    @diameter = diameter
  end
end


#-----DRIVERS-----
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

  diameters = basket.map { |orange| orange.diameter }
  avg_diameter = diameters.reduce(:+) / diameters.length

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"