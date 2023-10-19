class Product < ApplicationRecord
  include PaginationConcern
  has_one_attached :image
  has_many :line_items, dependent: :destroy
  has_many :carts, through: :line_items
  validates :title, :description, :product_stock_quantity, :price, :image, presence: true

  def reduce_stock_quantity(quantity)
    update(product_stock_quantity: product_stock_quantity - quantity)
  end
end
