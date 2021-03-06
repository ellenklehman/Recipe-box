require 'textacular'

class Cook < ActiveRecord::Base.extend(Textacular)
  has_many :boxes
  has_many :recipes

  validates :name, :presence => true
  validates_uniqueness_of :name

  before_save :downcase_name

  after_save do
    puts "You have created a new cook!"
    sleep(2)
  end

  def find_recipe(recipe_name)
    Recipe.find_by(:name => recipe_name)
  end

  def find_box(box_name)
    Box.find_by(:name => box_name)
  end

  def count_recipes
    self.recipes.count
  end

private
  def downcase_name
    name.downcase!
  end
end
