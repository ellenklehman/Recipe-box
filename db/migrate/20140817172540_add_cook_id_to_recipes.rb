class AddCookIdToRecipes < ActiveRecord::Migration
  def change
  	add_column :recipes, :cook_id, :integer
  end
end
