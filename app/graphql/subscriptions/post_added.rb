module Subscriptions
  class PostAdded < GraphQL::Schema::Subscription
    payload_type Types::PostType
  end
end
