class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.float :cart_total_price
      t.integer :cart_total_product_quantity
      t.timestamps
    end
  end
end
