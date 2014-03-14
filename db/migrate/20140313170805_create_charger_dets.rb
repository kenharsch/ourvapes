class CreateChargerDets < ActiveRecord::Migration
	def change
		create_table :charger_dets do |t|
			t.integer :charger_id

			t.timestamps
		end
	end
end
