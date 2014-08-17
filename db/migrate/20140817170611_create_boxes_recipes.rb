class CreateBoxesRecipes < ActiveRecord::Migration
  def change
    create_table :boxes_recipes do |t|
    	t.integer :recipe_id
    	t.integer :box_id

    	t.timestamps
    end
  end
end
