class CreateBatteryDets < ActiveRecord::Migration
	def change
		create_table :battery_dets do |t|
			t.integer :battery_id
			t.string :voltage
			t.string :wattage

			t.timestamps
		end
	end
end
