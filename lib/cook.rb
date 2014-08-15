
class Cook < ActiveRecord::Base
  has_many :recipes, :through => :recipe_box

  validates :name, :presence => true
  validates_uniqueness_of :name

  def find_recipe(recipe_name)
    Recipe.where(:name => recipe_name)
  end

  def find_recipe_box(recipe_box_name)
    RecipeBox.where(:name => recipe_box_name)
  end

end
