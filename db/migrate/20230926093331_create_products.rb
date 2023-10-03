class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.string :picture_url
      t.integer :price
      t.integer :product_quantity
      t.integer :product_stock_quantity
      t.timestamps
    end
  end
end
