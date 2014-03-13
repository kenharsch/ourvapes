class CreateMouthpieceDets < ActiveRecord::Migration
	def change
		create_table :mouthpiece_dets do |t|

			t.timestamps
		end
	end
end
