class Order < ApplicationRecord
  belongs_to :user
  belongs_to :cart
  validates :email, :country, :first_name, :last_name, :address, :city, :postal_code, :phone_number, presence: true
  validates :phone_number, presence: true, length: { is: 11 }, numericality: { only_integer: true }
end
