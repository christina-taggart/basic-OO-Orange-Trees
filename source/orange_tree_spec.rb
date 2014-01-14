require_relative 'orange_tree.rb'

describe OrangeTree do
  it "should start with a height of zero" do
    tree = OrangeTree.new
    expect(tree.height).to eq 0
  end

end