class Box < ActiveRecord::Base
  has_many :recipes
  belongs_to :cook

  validates :name, :presence => true
  validates_uniqueness_of :name

  after_save do
    puts "You have created a recipe box!"
  end
end
