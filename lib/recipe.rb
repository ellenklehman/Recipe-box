class Recipe < ActiveRecord::Base
  has_and_belongs_to_many :boxes
  belongs_to :cook

  validates :name, :instructions, :presence => true
  validates_uniqueness_of :name

  after_save do
    puts "You have created a recipe!"
  end
end
