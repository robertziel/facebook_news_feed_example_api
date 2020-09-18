class Post < ApplicationRecord
  # RELATIONS
  belongs_to :user

  # VALIDATIONS
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :user, presence: true
end
