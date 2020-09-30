class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Tokenizable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable, :recoverable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :devise,
         :validatable,
         :trackable,
         :jwt_authenticatable,
         jwt_revocation_strategy: self

  # RELATIONS
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :reactions, dependent: :destroy

  # VALIDATIONS
  validates :email, presence: true,
                    length: { maximum: 255 },
                    format: { with: Regex::Email::VALIDATE }
  validates :first_name, presence: true, length: { maximum: 255 }
  validates :last_name, presence: true, length: { maximum: 255 }

  def name
    "#{first_name} #{last_name}"
  end
end
