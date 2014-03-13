class CreateTankDets < ActiveRecord::Migration
	def change
		create_table :tank_dets do |t|

			t.float :volume_in_ml
			t.integer :connector_id

			t.timestamps
		end
	end
end
