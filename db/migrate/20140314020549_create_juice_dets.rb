class CreateJuiceDets < ActiveRecord::Migration
  def change
    create_table :juice_dets do |t|
      t.integer :juice_id
      t.integer :nicotine_in_ml

      t.timestamps
    end
  end
end
