require 'textacular'

class Box < ActiveRecord::Base.extend(Textacular)
  has_and_belongs_to_many :recipes
  belongs_to :cook

  validates :name, :presence => true
  validates_uniqueness_of :name

  before_save :downcase_name

  after_save do
    puts "You have created a recipe box!"
    sleep(2)
  end

private
  def downcase_name
    name.downcase!
  end
end
