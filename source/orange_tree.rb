# This is how you define your own custom exception classes
class NoOrangesError < StandardError
end

class OrangeTree
  attr_reader :height, :age, :oranges
  def initialize
    @height = 0
    @age = 0
    @oranges = []
  end
  # Ages the tree one year
  def age!
    season_ends!
    @age += 1
    @height += 5 if @age < 75
    rand(200..400).times {@oranges << Orange.new(rand(3..6).to_f)} if @age.between?(6,75) #add this year's oranges
  end

  def dead?
    @age >= 200
  end

  # Returns +true+ if there are any oranges on the tree, +false+ otherwise
  def any_oranges?
    @oranges != [] #or if you pick them all?
  end

  # Returns an Orange if there are any
  # Raises a NoOrangesError otherwise
  def pick_an_orange!(basket)
    raise NoOrangesError, "This tree has no oranges" unless self.any_oranges?
    # orange-picking logic goes here
    @oranges.pop.place_orange_in_basket(basket)
  end

  def season_ends!
    @oranges = []
  end

# we use this for leslie
#   def check_average_orange_diameter
#     diameters = []
#     @oranges.each{|orange| diameters << orange.diameter}
#     diameters.reduce(:+)/(diameters.length)
#   end

end


class Orange
  attr_reader :diameter
  def initialize(diameter)
    @diameter = diameter
  end

  def place_orange_in_basket(basket)
    basket.contents << self
  end
  # Initializes a new Orange with diameter +diameter+

end

class Basket
  attr_reader :contents
  def initialize
    @contents = []
  end

  def how_many_oranges_in_basket
    @contents.length
  end

  def check_average_orange_diameter
    diameters = []
    @contents.each{|orange| diameters << orange.diameter}
    diameters.reduce(:+)/(diameters.length)
  end

end

# our_basket = Basket.new

# puts "A new seed is planted...let's call her Leslie!"
# leslie = OrangeTree.new
# puts "Leslie is now five years old!"
# 5.times {leslie.age!}
# p leslie.age == 5
# p leslie.any_oranges? == false
# p leslie.oranges == []
# puts "Leslie ages another year! Happy 6th Birthday!"
# leslie.age!
# p leslie.age == 6
# p leslie.any_oranges? == true
# puts "What's the average diameter of this harvest?: #{leslie.check_average_orange_diameter.round(2)} inches."
# first_orange = leslie.oranges
# puts "Leslie ages another year! Happy 7th Birthday!"
# leslie.age!
# p leslie.age == 7
# p leslie.any_oranges? == true
# p leslie.oranges != first_orange
# p leslie.oranges.length == 300
# puts "Picking an orange!"
# leslie.pick_an_orange!(our_basket)
# p our_basket.how_many_oranges_in_basket == 1
# p leslie.oranges.length == 299
# puts "It was a short season"
# leslie.season_ends!
# # leslie.pick_an_orange! #=> should raise an error
# puts "Leslie ages another year! Happy 8th Birthday!"
# leslie.age!
# puts "The season ends and we didn't pick any oranges"
# leslie.season_ends!
# p leslie.any_oranges? == false
# puts "Many years pass..."
# 192.times {leslie.age!}
# p leslie.age
# p leslie.dead? == true
# puts "Leslie has moved on. Thank you Leslie"

tree = OrangeTree.new

tree.age! until tree.any_oranges?

puts "Tree is #{tree.age} years old and #{tree.height} feet tall"

until tree.dead?
  our_basket = Basket.new

  # It places the oranges in the basket
  # IT PLACES THE ORANGES IN THE BASKET
  while tree.any_oranges?
    tree.pick_an_orange!(our_basket)
  end
# puts "What's the average diameter of this harvest?: #{leslie.check_average_orange_diameter.round(2)} inches."

  if tree.age.between?(5,75)
    avg_diameter = our_basket.check_average_orange_diameter.round(2)
  else
    avg_diameter = 0
  end

  puts "Year #{tree.age} Report"
  puts "Tree height: #{tree.height} feet"
  puts "Harvest:     #{our_basket.contents.size} oranges with an average diameter of #{avg_diameter} inches"
  puts ""

  # Age the tree another year
  tree.age!
end

puts "Alas, the tree, she is dead!"