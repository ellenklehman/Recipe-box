class CreateRecipeBox < ActiveRecord::Migration
  def change
    create_table :recipe_boxes do |t|
      t.string :name
      t.belongs_to :cook

    end
  end
end
