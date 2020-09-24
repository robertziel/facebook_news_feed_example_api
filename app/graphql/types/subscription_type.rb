module Types
  class SubscriptionType < GraphQL::Schema::Object
    field :post_added, subscription: Subscriptions::PostAdded
  end
end
