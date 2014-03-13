class CreateChargerDets < ActiveRecord::Migration
  def change
    create_table :charger_dets do |t|

      t.timestamps
    end
  end
end
