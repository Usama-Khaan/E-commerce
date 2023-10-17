class AddColumnLineitems < ActiveRecord::Migration[7.0]
  def change
    add_column :line_items, :line_items_quantity, :integer
  end
end
