class User < ApplicationRecord
  #  :lockable, :timeoutable, :trackable and :omniauthable
  PASSWORD_REGEX = /\A.*[[:punct:]]+\z/
  PASSWORD_MESSAGE = 'must contain at least one special character'
  devise :database_authenticatable, :confirmable, :registerable, :rememberable, :validatable
  validates :password, format: { with: PASSWORD_REGEX, message: PASSWORD_MESSAGE }, on: :create
  has_many :permissions, dependent: :destroy
  has_many :roles, through: :permissions
  validates :username, :email, :role_ids, presence: true

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
