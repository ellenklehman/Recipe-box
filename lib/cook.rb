class Cook < ActiveRecord::Base
  has_many :recipes, :through => :recipe_box

  validates :name, :presence => true
  validates_uniqueness_of :name
end
