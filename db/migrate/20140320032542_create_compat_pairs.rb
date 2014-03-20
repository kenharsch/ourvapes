class CreateCompatPairs < ActiveRecord::Migration
  def change
    create_table :compat_pairs, id: false do |t|
      t.integer :prod1_id
      t.integer :prod2_id

      t.timestamps
    end
  end
end
