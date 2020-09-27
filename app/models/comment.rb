class Comment < ApplicationRecord
  # Relations
  belongs_to :post
  belongs_to :user

  # Validations
  validates :content, presence: true
end