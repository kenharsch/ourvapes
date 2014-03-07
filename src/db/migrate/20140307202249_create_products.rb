class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :type
      t.string :name
      t.integer :manufacturer_id
      t.text :description
      t.string :picture
      t.float :volume_in_ml
      t.integer :connector
      t.float :resistance_in_ohm
      t.float :nicotine_in_mg
      t.integer :mouthpiece_id
      t.integer :tank_id
      t.integer :wick_id
      t.integer :button_id
      t.integer :battery_id
      t.integer :cartridge_id
      t.integer :charger_id

      t.timestamps
    end
  end
end
