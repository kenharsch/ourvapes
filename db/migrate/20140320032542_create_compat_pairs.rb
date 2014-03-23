class CreateCompatPairs < ActiveRecord::Migration
	def change
		create_table :compat_pairs, id: false do |t|
			t.integer :prod1_id
			t.integer :prod2_id
			t.boolean :works_well, default: true
			t.timestamps
		end

		add_index :compat_pairs, [:prod1_id, :prod2_id], :unique => true
	end
end
