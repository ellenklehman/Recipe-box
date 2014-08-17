class RemoveRecipeBoxId < ActiveRecord::Migration
  def change
  	remove_column :recipes, :recipe_box_id
  end
end
