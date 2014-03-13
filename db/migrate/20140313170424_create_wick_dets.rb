class CreateWickDets < ActiveRecord::Migration
  def change
    create_table :wick_dets do |t|
      t.float :resistance_in_ohm
      t.integer :connector_id

      t.timestamps
    end
  end
end
