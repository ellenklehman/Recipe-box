require 'textacular'

class Cook < ActiveRecord::Base.extend(Textacular)
  has_many :boxes
  has_many :recipes

  validates :name, :presence => true
  validates_uniqueness_of :name

  before_save :downcase_name

  after_save do
    puts "You have created a new cook!"
    sleep(1)
  end

  def find_recipe(recipe_name)
    Recipe.where(:name => recipe_name)
  end

  def find_box(box_name)
    Box.where(:name => box_name)
  end

  def count_recipes
    puts "Recipe count: " + self.recipes.count
  end

private
  def downcase_name
    name.downcase!
  end
end
