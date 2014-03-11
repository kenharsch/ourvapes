class CreateConfigControllers < ActiveRecord::Migration
  def change
    create_table :config_controllers do |t|
      t.string :show

      t.timestamps
    end
  end
end
