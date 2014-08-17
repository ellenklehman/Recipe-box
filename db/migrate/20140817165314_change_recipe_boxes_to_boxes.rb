class ChangeRecipeBoxesToBoxes < ActiveRecord::Migration
  def change
  	rename_table :recipe_boxes, :boxes
  end
end
