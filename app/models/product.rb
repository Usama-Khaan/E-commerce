class Product < ApplicationRecord
  has_one_attached :image
  validates :title, :description, :product_stock_quantity, :price, presence: true
end
