class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :rating
      t.integer :rating_count
      t.string :description
      t.string :picture_path
      t.string :type
      t.string :manufacturer
      t.float :price

      t.timestamps
    end
  end
end
