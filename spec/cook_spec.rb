require 'spec_helper'

describe Cook do
  it { should validate_presence_of :name}
  it { should validate_uniqueness_of :name}

  describe '#find_recipe' do
    it 'returns a specific recipe based on a search' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_recipe_box = RecipeBox.create({:name => 'Baked Goods', :cook_id => test_cook.id})
      test_recipe = Recipe.create({:name => 'Cookies', :instructions => "buy cookies at bakery", :recipe_box_id => test_recipe_box.id})
      another_test_recipe = Recipe.create({:name => "Cakes", :instructions => "Buy a box.  Mix ingredients. Put in oven.", :recipe_box_id => test_recipe_box.id})
      expect(test_cook.find_recipe('Cookies')).to eq [test_recipe]
    end
  end
end
