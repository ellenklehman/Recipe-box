
class Cook < ActiveRecord::Base
  has_many :boxes
  has_many :recipes, :through => :box

  validates :name, :presence => true
  validates_uniqueness_of :name

  def find_recipe(recipe_name)
    Recipe.where(:name => recipe_name)
  end

  def find_box(box_name)
    Box.where(:name => box_name)
  end

  def count_recipes
    self.recipes.count
  end
end
