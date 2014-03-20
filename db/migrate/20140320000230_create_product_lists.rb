class CreateProductLists < ActiveRecord::Migration
  def change
    create_table :product_lists do |t|

      t.timestamps
    end
  end
end
