class AddRefernceKeysToOrder < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :user, foreign_key: true
    add_reference :orders, :cart, foreign_key: true
  end
end
