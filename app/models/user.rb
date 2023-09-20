class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  PASSWORD_REGEX = /\A.*[[:punct:]]+\z/
  PASSWORD_MESSAGE = 'must contain at least one special character'
  devise :database_authenticatable, :registerable, :rememberable, :validatable
  validates :password, format: { with: PASSWORD_REGEX, message: PASSWORD_MESSAGE }, on: :create
end
