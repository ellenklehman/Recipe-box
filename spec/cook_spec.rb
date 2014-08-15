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

  describe '#find_recipe_box' do
    it 'returns a recipe box based on a search' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_recipe_box = RecipeBox.create({:name => 'Baked Goods', :cook_id => test_cook.id})
      another_test_recipe_box = RecipeBox.create({:name => 'Chinese', :cook_id => test_cook.id})
      expect(test_cook.find_recipe_box('Chinese')).to eq [another_test_recipe_box]
    end
  end

  describe '#count_recipes' do
    it 'counts how many recipes a cook has' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_recipe_box = RecipeBox.create({:name => 'Baked Goods', :cook_id => test_cook.id})
      test_recipe = Recipe.create({:name => 'Cookies', :instructions => "buy cookies at bakery", :recipe_box_id => test_recipe_box.id})
      another_test_recipe = Recipe.create({:name => "Cakes", :instructions => "Buy a box.  Mix ingredients. Put in oven.", :recipe_box_id => test_recipe_box.id})
      expect(test_cook.count_recipes).to eq 2
    end
  end

end
