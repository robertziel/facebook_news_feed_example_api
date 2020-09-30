module Types
  class SubscriptionType < GraphQL::Schema::Object
    # Comments
    field :comment_added, subscription: Subscriptions::CommentAdded

    # Posts
    field :post_added, subscription: Subscriptions::PostAdded
  end
end
