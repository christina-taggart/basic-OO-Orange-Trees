require_relative '../source/orange_tree.rb'

describe OrangeTree do

  let(:my_tree) { OrangeTree.new }

  describe "when I create an orange tree" do
    it "should have a height of zero" do
      expect(my_tree.height).to eq 0
    end

    it "should have an age of zero" do
      expect(my_tree.age).to eq 0
    end
  end

  describe "the age! method" do
    it "should age the tree by one year" do
      my_tree.age!
      expect(my_tree.age).to eq 1
    end

    it "should be between 3 and 6 after three years" do
      3.times{ my_tree.age! }
      expect(my_tree.height).to be_within(3).of(6)
    end

    it "should be between 15 and 29 after seven years" do
      7.times{ my_tree.age! }
      expect(my_tree.height).to be_within(9).of(24)
    end

    it "should be between 18 and 39 after ten years" do
      10.times{ my_tree.age! }
      expect(my_tree.height).to be_within(10.5).of(28.5)
    end

    it "should not produce oranges in first 2 years" do
      2.times do
        my_tree.age!
        expect(my_tree.oranges.length).to eq 0
      end
    end

    it "should randomly produce 2 or 3 more oranges at age three" do

      3.times { my_tree.age! }

      expect(my_tree.oranges.length).to be >= 2
      expect(my_tree.oranges.length).to be <= 3
    end

    it "should produce 1.5 to 2.5 times more oranges as the previous year when age 4-10" do
      3.times { my_tree.age! }

      7.times do
        prev_oranges = my_tree.oranges.length
        my_tree.age!
        curr_oranges = my_tree.oranges.length

        expect(curr_oranges).to be >= (prev_oranges + (prev_oranges * 1.5))
        expect(curr_oranges).to be <= (prev_oranges + (prev_oranges * 2.5))
      end
    end
  end

  describe "the dead? method" do
    it "should return false when the tree is between 0 and 10" do
      10.times do
        expect(my_tree.dead?).to be_false
        my_tree.age!
      end
      expect(my_tree.dead?).to be_false
    end

    it "should return true when the tree age is over 10" do
      11.times { my_tree.age! }
      expect(my_tree.dead?).to be_true
    end
  end

  describe "the any_oranges? method" do
    it "should not have oranges at age two" do
      2.times{ my_tree.age! }
      expect(my_tree.any_oranges?).to be_false
    end

    it "should have oranges after age three" do
      3.times{ my_tree.age! }
      expect(my_tree.any_oranges?).to be_true
    end

    it "should have no oranges at age 11" do
      11.times{ my_tree.age! }
      expect(my_tree.any_oranges?).to be_false
    end
  end

  describe "the pick_an_orange! method" do
    it "should not return an orange when there are no oranges" do
      2.times{ my_tree.age! }
      expect { my_tree.pick_an_orange! }.to raise_error(NoOrangesError)
    end

    it "should return one orange when there are oranges" do
      3.times{ my_tree.age! }
      oranges = my_tree.oranges.length
      expect(my_tree.pick_an_orange!).not_to be_nil
      expect(my_tree.oranges.length).to eq oranges - 1
    end
  end

end

describe Orange do

  describe "when I create an orange" do

    let(:set_diameter) { 5 }
    let(:my_orange) { Orange.new(set_diameter) }

    it "should have a set diameter" do
      expect(my_orange.diameter).to eq set_diameter
    end
  end

end