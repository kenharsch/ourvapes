class CreateMouthpieces < ActiveRecord::Migration
  def change
    create_table :mouthpieces do |t|

      t.timestamps
    end
  end
end
