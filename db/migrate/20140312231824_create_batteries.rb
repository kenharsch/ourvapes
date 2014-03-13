class CreateBatteries < ActiveRecord::Migration
  def change
    create_table :batteries do |t|

      t.timestamps
    end
  end
end
