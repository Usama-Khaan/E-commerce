class LineItemsController < ApplicationController
  def update_line_items
    quantities = params[:quantities]
    quantities.each do |line_item_id, quantity|
      line_item = LineItem.find(line_item_id)
      line_item.update(line_items_quantity: quantity)
    end
    head :ok
  end
end
