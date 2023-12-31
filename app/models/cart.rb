class Cart < ApplicationRecord
  belongs_to :user
  has_one :order
  has_many :line_items, dependent: :destroy
  has_many :products, through: :line_items
end
