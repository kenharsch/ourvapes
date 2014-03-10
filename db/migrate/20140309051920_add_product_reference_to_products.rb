class AddProductReferenceToProducts < ActiveRecord::Migration
  def change
    add_reference :products, :wick, index: true
    add_reference :products, :tank, index: true
  end
end
