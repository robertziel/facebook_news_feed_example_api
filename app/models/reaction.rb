class Reaction < ApplicationRecord
  LIKE = 'like'.freeze
  SMILE = 'smile'.freeze
  THUMBS_UP = 'thumbsUp'.freeze
  TYPES = [LIKE, SMILE, THUMBS_UP].freeze

  # Relations
  belongs_to :comment
  belongs_to :user

  # Validations
  validates :reaction_type, inclusion: { in: TYPES }
  validates :user_id, uniqueness: { scope: :comment_id }
end
