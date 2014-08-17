require 'spec_helper'


describe Cook do
  it { should validate_presence_of :name}
  it { should validate_uniqueness_of :name}

  describe '#find_recipe' do
    it 'returns a specific recipe based on a search' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_box = Box.create({:name => 'Baked Goods', :cook_id => test_cook.id})
      test_recipe = test_box.recipes.create({:name => 'Cookies', :instructions => "buy cookies at bakery"})
      another_test_recipe = test_box.recipes.create({:name => "Cakes", :instructions => "Buy a box.  Mix ingredients. Put in oven."})
      expect(test_cook.find_recipe('cookies')).to eq test_recipe
    end
  end

  describe '#find_box' do
    it 'returns a recipe box based on a search' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_box = Box.create({:name => 'Baked Goods', :cook_id => test_cook.id})
      another_test_box = Box.create({:name => 'Chinese', :cook_id => test_cook.id})
      expect(test_cook.find_box('chinese')).to eq another_test_box
    end
  end

  describe '#count_recipes' do
    it 'counts how many recipes a cook has' do
      test_cook = Cook.create({:name => "Cookie Monster"})
      test_recipe = test_cook.recipes.create({:name => 'Cookies', :instructions => "buy cookies at bakery", :cook_id => test_cook.id})
      another_test_recipe = test_cook.recipes.create({:name => "Cakes", :instructions => "Buy a box.  Mix ingredients. Put in oven.", :cook_id => test_cook.id})
      expect(test_cook.count_recipes).to eq 2
    end
  end

end
