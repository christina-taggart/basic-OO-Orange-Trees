class Tree
  attr_reader :height, :fruits, :growth_rate, :age_limit, :fruit_class, :height_limit, :fruit_production_rate, :maturity_age, :name, :dead, :age
  def initialize(growth_rate, age_limit, fruit_class, height_limit, fruit_production_rate, maturity_age, name)
    @growth_rate = growth_rate
    @age_limit = age_limit
    @fruit_class = fruit_class
    @height_limit = height_limit
    @fruit_production_rate = fruit_production_rate
    @maturity_age = maturity_age
    @name = name
    @age = 0
    @height = 0
    @fruits = []
  end

  def age!
    age_year
    grow_height
    grow_fruit
  end

  def age_year
    @age += 1 if @age < @age_limit
    @dead = true if @age == @age_limit
  end

  def grow_height
    @height += @growth_rate if @height < @height_limit
  end

  def grow_fruit
    rand(@fruit_production_rate).times { @fruits << @fruit_class.new} if @age > @maturity_age
  end

  def has_fruit
    @fruits.length > 0 ? true : false
  end
end

class OrangeTree < Tree
  def initialize
    super(5, 30, Orange, 20, 5, 3, "Orange Tree")
  end
end

class AppleTree < Tree
  def initialize
    super(4, 35, Apple, 23, 4, 5, "Apple Tree")
  end
end

class PearTree < Tree
  def initialize
    super(2, 23, Pear, 19, 9, 4, "Pear Tree" )
  end
end

class TreeGrove
  def initialize(orange = 0, apple = 0, pear = 0)
    @grove = []
    orange.times{@grove << OrangeTree.new}
    apple.times{@grove << AppleTree.new}
    pear.times{@grove << PearTree.new}
  end

  def age!
    @grove.each do |tree|
      tree.age!
    end
  end

  def trees
    @grove.map{|tree| tree.name}
  end

  def mature_trees
    @grove.find_all{|tree| tree.age > tree.maturity_age}.map {|tree| tree.name}
  end

  def dead_trees
    @grove.find_all{|tree| tree.dead}.map {|tree| tree.name}
  end
end


class Fruit
  attr_reader :name, :avg_size, :variance, :diameter
  def initialize(name, avg_size, variance)
    @name = name
    @avg_size = avg_size
    @variance = variance
    @diameter = @avg_size + rand(@variance) - rand(@variance)
  end
end

class Orange < Fruit
  def initialize
    super("Orange", 4, 2)
  end
end

class Apple < Fruit
  def initialize
    super("Apple", 5, 3)
  end
end

class Pear < Fruit
  def initialize
    super("Pear", 3, 2)
  end
end

class Person
  attr_reader :basket, :avg
  def initialize
    @basket = []
  end

  def pick(tree)
    @basket << tree.fruits.pop(tree.fruits.length)
    @basket = @basket.flatten
  end

  def calc_diameter
    total_size = 0
    @basket.each { |fruit| total_size += fruit.diameter}
    @avg = total_size.to_f / @basket.length
  end
end

# orange_tree = OrangeTree.new
# person = Person.new

# while orange_tree.dead != true
#   orange_tree.age!
#   person.pick(orange_tree) if orange_tree.has_fruit
# end

# puts "Year #{orange_tree.age} Report:"
# puts "Tree height is #{orange_tree.height}"
# puts "Harvest is #{person.basket.length}"

# person.calc_diameter
# puts "Average Diameter is #{person.avg}"

grove = TreeGrove.new(5,5,5)

30.times {grove.age!}


puts "All Trees:"
p grove.trees
puts "Dead Trees"
p grove.dead_trees
puts "Mature Trees"
p grove.mature_trees




