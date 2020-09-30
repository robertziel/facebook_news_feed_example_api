module Subscriptions
  class CommentAdded < GraphQL::Schema::Subscription
    argument :post_id, ID, required: true
    payload_type Types::CommentType

    def subscribe(post_id:); end
  end
end
