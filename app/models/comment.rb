class Comment < ApplicationRecord
  # Relations
  belongs_to :post
  belongs_to :user
  has_many :reactions, dependent: :destroy

  # Validations
  validates :content, presence: true, length: { maximum: 500 }

  # Callbacks
  after_commit :notify_subscriber_of_addition, on: :create

  def update_reactions_counts
    update_columns(
      like_reactions_count: reactions.likes.count,
      smile_reactions_count: reactions.smiles.count,
      thumbs_up_reactions_count: reactions.thumbs_ups.count
    )
  end

  private

  def notify_subscriber_of_addition
    GraphqlSchema.subscriptions.trigger('commentAdded', { post_id: post_id }, self)
  end
end
