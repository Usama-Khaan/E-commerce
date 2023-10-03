class Product < ApplicationRecord
  include PaginationConcern
  has_one_attached :image
  has_many :line_items
  has_many :carts, :through => :line_items
  validates :title, :description, :product_stock_quantity, :price, presence: true
end
