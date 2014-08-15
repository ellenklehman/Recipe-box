class Recipe < ActiveRecord::Base
  belongs_to :recipe_box

  validates :name, :instructions, :presence => true
  validates_uniqueness_of :name
end
