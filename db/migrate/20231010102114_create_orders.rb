class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :email, null: false
      t.string :country
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :postal_code
      t.string :phone_number
      t.timestamps
    end
    add_index :orders, :email, unique: true
  end
end
