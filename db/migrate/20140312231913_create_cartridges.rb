class CreateCartridges < ActiveRecord::Migration
  def change
    create_table :cartridges do |t|

      t.timestamps
    end
  end
end
