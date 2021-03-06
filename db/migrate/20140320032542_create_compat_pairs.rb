class CreateCompatPairs < ActiveRecord::Migration
	def change
		create_table :compat_pairs do |t|
			t.integer :prod1_id
			t.integer :prod2_id
			t.integer :compatibility
			t.timestamps
		end

		add_index(:compat_pairs, :prod1_id)
		add_index(:compat_pairs, :prod2_id)
	end
end
