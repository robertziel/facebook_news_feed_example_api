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

  # - RELATIONS
  # -

  # VALIDATIONS
  validates :email, presence: true
  validates :email, length: { maximum: 255 }
  validates :email, format: { with: Regex::Email::VALIDATE }
  validates :first_name, presence: true
  validates :first_name, length: { maximum: 255 }
  validates :last_name, presence: true
  validates :last_name, length: { maximum: 255 }

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  def name
    "#{first_name} #{last_name}"
  end
end
