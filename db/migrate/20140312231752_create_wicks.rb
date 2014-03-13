class CreateWicks < ActiveRecord::Migration
  def change
    create_table :wicks do |t|
      t.float :resistance_in_ohm
      t.integer :connector_id

      t.timestamps
    end
  end
end
