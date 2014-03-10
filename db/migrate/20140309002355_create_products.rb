class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :type
      t.string :title
      t.string :descripton

      t.timestamps
    end
  end
end
