class CreateConnectors < ActiveRecord::Migration
  def change
    create_table :connectors do |t|
      t.string :name

      t.timestamps
    end
  end
end
