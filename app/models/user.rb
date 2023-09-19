class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :password,
            format: { with: /\A.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\|-]+\z/,
                      message: 'must contain at least one special character' }
end
