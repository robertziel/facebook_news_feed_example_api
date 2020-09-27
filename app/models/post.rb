class Post < ApplicationRecord
  # Relations
  belongs_to :user
  has_many :comments, dependent: :destroy

  # Validations
  validates :content, presence: true
  validates :title, presence: true, length: { maximum: 255 }
  validates :user, presence: true

  # Callbacks
  after_commit :notify_subscriber_of_addition, on: :create

  private

  def notify_subscriber_of_addition
    GraphqlSchema.subscriptions.trigger('postAdded', {}, self)
  end
end
