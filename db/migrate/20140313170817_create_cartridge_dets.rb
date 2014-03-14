class CreateCartridgeDets < ActiveRecord::Migration
	def change
		create_table :cartridge_dets do |t|
			t.integer :cartridge_id

			t.timestamps
		end
	end
end
