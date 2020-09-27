class Comment < ApplicationRecord
  # Relations
  belongs_to :post
  belongs_to :user

  # Validations
  validates :content, presence: true, length: { maximum: 500 }
end
