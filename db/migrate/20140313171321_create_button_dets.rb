class CreateButtonDets < ActiveRecord::Migration
  def change
    create_table :button_dets do |t|
      t.integer :button_id

      t.integer :connector_id

      t.timestamps
    end
  end
end
