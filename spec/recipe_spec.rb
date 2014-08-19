require 'spec_helper'

describe Recipe do

  it { should have_and_belong_to_many :boxes }
  it { should belong_to :cook }
  it { should validate_presence_of :name}
  it { should validate_presence_of :instructions}
  it { should validate_uniqueness_of :name }

  describe 'self.recent' do
  	it 'will return the most recently added recipes' do
  		test_cook = Cook.create({:name => "Cookie Monster"})
  		test_recipe = test_cook.recipes.create({:name => 'Cookies', :instructions => "buy cookies at bakery", :cook_id => test_cook.id, :created_at => Date.today - 10})
  		another_test_recipe = test_cook.recipes.create({:name => "Cakes", :instructions => "Buy a box.  Mix ingredients. Put in oven.", :cook_id => test_cook.id, :created_at => Date.today - 4})
  		expect(Recipe.recent.first).to eq another_test_recipe
  	end
  end
end
