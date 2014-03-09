class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.string :descripton
      t.string :type

      t.timestamps
    end
  end
end
