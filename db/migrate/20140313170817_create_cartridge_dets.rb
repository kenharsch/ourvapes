class CreateCartridgeDets < ActiveRecord::Migration
  def change
    create_table :cartridge_dets do |t|

      t.timestamps
    end
  end
end
