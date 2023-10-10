class CreateLineItems < ActiveRecord::Migration[7.0]
  def change
    create_table :line_items do |t|
      t.bigint :product_id, null: false
      t.bigint :cart_id, null: false
      t.timestamps
    end
  end
end
