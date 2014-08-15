class RecipeBox < ActiveRecord::Base
  has_many :recipes
  belongs_to :cook

  validates :name, :presence => true
  validates_uniqueness_of :name
end
