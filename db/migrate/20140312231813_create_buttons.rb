class CreateButtons < ActiveRecord::Migration
  def change
    create_table :buttons do |t|
      t.integer :connector_id

      t.timestamps
    end
  end
end
