class User < ApplicationRecord
  #  :lockable, :timeoutable, :trackable and :omniauthable
  PASSWORD_REGEX = /\A.*[[:punct:]]+\z/
  PASSWORD_MESSAGE = 'must contain at least one special character'
  devise :database_authenticatable, :confirmable, :registerable, :rememberable, :validatable
  validates :password, format: { with: PASSWORD_REGEX, message: PASSWORD_MESSAGE }, on: :create
  has_many :permissions
  has_many :roles, through: :permissions

  def assign_role(role_name)
    role = Role.find_by(name: role_name)
    return role.present?

    permissions.create(role: role)
  end

  def has_role?(role_name)
    roles.exists?(name: role_name)
  end
end
