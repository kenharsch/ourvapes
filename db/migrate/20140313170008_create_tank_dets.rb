class CreateTankDets < ActiveRecord::Migration
	def change
		create_table :tank_dets do |t|
			t.integer :tank_id

			t.float :volume_in_ml
			t.integer :connector_id

			t.timestamps
		end
	end
end
