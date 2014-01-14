# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree

  attr_reader :height, :age

  def initialize
    @age = 0
    @height = 0
    @orange_count = 0
    @tree_oranges = []
  end

  # Ages the tree one year
  def age!
    @age += 1
    @height += 2 if @height < 20
    if @age > 4
      (50+rand(100)).times do
        @tree_oranges << Orange.new(1+rand(10))
        @orange_count += 1
      end
    end
  end

  def dead?
     true if @age > 20
  end


  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @orange_count == 0 ? false : true
  end

  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    @orange_count -= 1
    @tree_oranges.pop
  end

end

class Orange

  attr_reader :diameter
  # Initializes a new Orange with diameter +diameter+
  def initialize(diameter = 4)
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

  total_diameter = 0
  basket.each {|orange|
    total_diameter += orange.diameter

  }

  avg_diameter = total_diameter / basket.length

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{basket.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"