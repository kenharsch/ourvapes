class CreateMouthpieceDets < ActiveRecord::Migration
	def change
		create_table :mouthpiece_dets do |t|
			t.integer :mouthpiece_id

			t.timestamps
		end
	end
end
