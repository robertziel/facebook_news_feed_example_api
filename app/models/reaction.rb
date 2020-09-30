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

  # Scopes
  scope :likes, -> { where(reaction_type: LIKE) }
  scope :smiles, -> { where(reaction_type: SMILE) }
  scope :thumbs_ups, -> { where(reaction_type: THUMBS_UP) }

  # Callbacks
  after_save :update_comment_reactions_counts
  after_destroy :update_comment_reactions_counts

  private

  # Callbacks
  def update_comment_reactions_counts
    comment.update_reactions_counts
  end
end
