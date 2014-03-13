class CreateChargers < ActiveRecord::Migration
  def change
    create_table :chargers do |t|

      t.timestamps
    end
  end
end
