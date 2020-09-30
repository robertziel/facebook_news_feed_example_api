class Comment < ApplicationRecord
  # Relations
  belongs_to :post
  belongs_to :user
  has_many :reactions, dependent: :destroy

  # Validations
  validates :content, presence: true, length: { maximum: 500 }

  # Callbacks
  after_commit :notify_subscriber_of_addition, on: :create

  private

  def notify_subscriber_of_addition
    GraphqlSchema.subscriptions.trigger('commentAdded', { post_id: post_id }, self)
  end
end
