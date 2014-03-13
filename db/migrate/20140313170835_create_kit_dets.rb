class CreateKitDets < ActiveRecord::Migration
	def change
		create_table :kit_dets do |t|
			t.integer :mouthpiece_id
			t.integer :tank_id
			t.integer :wick_id
			t.integer :button_id
			t.integer :battery_id
			t.integer :charger_id
			t.integer :cartridge_id

			t.timestamps
		end
	end
end
